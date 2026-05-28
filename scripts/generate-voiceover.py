import asyncio, os, sys

script = """你花两个小时憋一个标题，发出去五十个阅读。

我用AI十秒生成二十个标题，同一条内容，阅读差了十倍。问题不在内容，在标题。

第一个技巧，喂对素材。

大多数人写"帮我起个标题"，AI一脸懵。你应该喂：我是谁、写给谁看、解决了什么问题、想要什么风格、字数限制。一句精准的提示词，比一百句模糊的好。

第二个技巧，用爆款公式。

你过去起标题是不是打开空白文档硬想？太慢了。把小红书七十五个验证过的标题公式喂给AI，让它匹配你的内容。数字公式、痛点公式、反常识公式，AI帮你选，不是帮你猜。

第三个技巧，让AI自我批判。

生成三个标题后，追加一句：假设你是小红书爆款标题评审，挑出最差的一个并解释为什么，然后改进它。AI会自己淘汰、自己升级，比你自己判断快十倍。

这三个技巧的完整提示词模板，我都放在主页了。点赞收藏，下次好找。"""

async def main():
    import edge_tts
    output_dir = os.path.join(os.path.dirname(__file__), "..", "projects", "2026-05-28")
    os.makedirs(output_dir, exist_ok=True)
    output_path = os.path.join(output_dir, "ai-xhs-titles-voiceover.mp3")

    # zh-CN-XiaoxiaoNeural = 自然女声, 语速 -5% 适合教学
    communicate = edge_tts.Communicate(script, "zh-CN-XiaoxiaoNeural", rate="-5%")
    print("Generating voiceover with Edge TTS (Xiaoxiao, rate=-5%)...")
    await communicate.save(output_path)
    size = os.path.getsize(output_path)
    print(f"Done: {output_path}")
    print(f"Size: {size} bytes ({size/1024:.0f} KB)")

asyncio.run(main())
