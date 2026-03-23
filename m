Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7D3F483E6
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 19:15:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44C3F40654;
	Mon, 23 Mar 2026 20:15:46 +0100 (CET)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id C8EAD402D6
 for <dev@dpdk.org>; Mon, 23 Mar 2026 20:15:44 +0100 (CET)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-669720ca6c3so884475a12.1
 for <dev@dpdk.org>; Mon, 23 Mar 2026 12:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774293344; cv=none;
 d=google.com; s=arc-20240605;
 b=FLQHGh5TgXebqPQktklO9XAH+teoTWg8K9oiARFvxkwBgHG6M49P/peUBehYhBgjTx
 ncLCebmJs3RfPDA+2VO1Yk+XvPzGTe3Jv2RZ3piIsJFr3J1FSRUKjWFiheYzev5W42+h
 1FNgynBspeTd3UspupOX+l8+2Bk7Ekh2GnK6QYjH7HqbxEK5fl/d2BEqRHY+nk6J0/1l
 BAopxLdFiQEhXWAn8om4ATVTeH6SGSn5//Jkn3Pd/hxXRCDh3IDZMpn4I/3BIT+ywnnL
 ER0XCxXYgwc1hwK/h1aNPR3qty5wnvphxZ67J6qGhotdiJp3dnUQ6beGr+NNciB+PwKJ
 UVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=a//kkJmWZ4tc55oFLf5zyd06FXl3iyjnSrBWVbwqbvc=;
 fh=BZqXEwALApxsogqGWx4lzVkI4rWpsYITFukVEGgpeuk=;
 b=e4euYezxLptKN4adODFLLnbnkOpMjNPWUJVVGEfNojfgC5rO3htV3lPUmeUdgykioa
 SyQgL8JxDxLDROJMfuAag77uz12vE6tp4YNTW3hOMGEiLxsokB5sXOxIxYcLHw67gz62
 HZcNw04+AQ+73VmCt6rd34wFrkFEMB/xRJxxEUyzsXpnXl0+ZmyMqDv1DEdVqHukkT32
 JUzzhn52SqRFQV2jAzwMN/uGrJp8Pgeb9rcDBKB9Ed6JdB61C/ZhQh6md7ecCtwYtV68
 zns8vMa/MdAhQ/rUUqAojIRhUM9g2g2O8XPLhyU+GUQMAGHtmW8ffHFi2z8rJcZxB971
 dF0Q==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774293344; x=1774898144; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a//kkJmWZ4tc55oFLf5zyd06FXl3iyjnSrBWVbwqbvc=;
 b=WRnDXClBhX1T0Km3pyivP1Bj+8b0ot5UJMxcxsNeJ1v2WBtI4QjumA6QABFtayJd27
 XAOtIpoxjY/sAZhfblIqCYDXRETCfNiGxjX/l3oXcRdxnacaODQMGCW7oSaHSdy0jFCM
 mcJASdhjDGQ/LI8ZO5OFBl4n/u5NP/zrDRpqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774293344; x=1774898144;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a//kkJmWZ4tc55oFLf5zyd06FXl3iyjnSrBWVbwqbvc=;
 b=gmm5re0dC4Y0lQNUzyh3n351SCy2rQ0q5ad2GhF8Ufp59uDbFpwRkWSqGlCULUSeqK
 Zy49EMwNiFPH87SIMOw/XyueNFCscuB9D5pw903lo0ULvS4icaj7FJPZLn60yRuZPyz3
 9H55UmedFy2sJUYiTRZv1yfJat5+I5v0ntVxE+z2rCrQtDUhu2bZWirlkQFS207mReci
 VPHP8S45TpfMsE1uHfxeTSRPeG+wHKJBdOrPp5nlzN0rJOF7gi2jZJ7Kf3OaJBahSggk
 YA6as+DFpc+rgDvj/26/Qyep/LDn84Qh9FuFVkaDaoTI6leFHPHf5TjqVW7HHZMQ2tuV
 LY0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT4oY42PFfTGJK+NCOUwHtJYXxHiqd2HPV0aFASSTBIjXby6y9HFdHnrxFwjymoAG5raY=@dpdk.org
X-Gm-Message-State: AOJu0YzackprD22OQEwjLrZwnnHHxxAuNeumlpoqfOQf5y9tow+Qet/7
 iv60Ce2oR463cbbcBaiPYUqoQVyF88dOXq/8NT+fEvMTnbL0qK9hrJWAGPuBh12V1HXpsENzORa
 u5MymkjrnfIo/tJ4rFzIejPYKyaG5fv7xAWbsrW8Wyw==
X-Gm-Gg: ATEYQzyKyg8/zGvCPiZUPLVAPrIEjufkRcr/I85u2rD+RoqviBFIz8T2h2W7iHBBJp4
 LIY9ezwPLGofQuOHpZHNs3U8jUpUIS5sa90vOpsJBH+f6a6Of4nLT2zYaAlToZRlFdKw4ntHHV+
 Zk9RVhEPaF/WhfTdfcc+hSF3UxR7/zcOF4SbpsujyMI8O1LqmMXDt4CSLdaI/g/bcAGpdXBiT7O
 8ogWOcKmlszKddpqfgIkv+9ZUI0Ax9ogTS0WffX/0gAViD7EMkEkJiAy13tofl+biWK9P6rKtuR
 n+oajSj8q3brAPfq93DMlZMjgaN6bKpYsoUb8BAL
X-Received: by 2002:a17:906:27d7:b0:b98:2641:be5e with SMTP id
 a640c23a62f3a-b982f399b5amr745883766b.27.1774293344348; Mon, 23 Mar 2026
 12:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260323180818.674041-1-probb@iol.unh.edu>
 <20260323180818.674041-3-probb@iol.unh.edu>
In-Reply-To: <20260323180818.674041-3-probb@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Mon, 23 Mar 2026 15:15:32 -0400
X-Gm-Features: AQROBzA6_kBefJJpzwl-u89UsgZ8EocAlR1bN5EUsAEETe5s8FAHATBiLT_Xf08
Message-ID: <CABJ3N2V7=3tsbXDuBsTryjABM0E_rc8VX-MDTigA2jZqLZSWMw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dts: avoid dpdk resources conflict
To: Patrick Robb <probb@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu, 
 knimoji@iol.unh.edu, Paul.Szczepanek@arm.com
Content-Type: multipart/alternative; boundary="000000000000847f51064db5dce9"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

--000000000000847f51064db5dce9
Content-Type: text/plain; charset="UTF-8"

Tested-by: Andrew Bailey <abailey@iol.unh.edu>
Reviewed-by Andrew Bailey <abailey@iol.unh.edu>

--000000000000847f51064db5dce9
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Tested-by: Andrew Bailey &lt;<a href="mailto:abailey@iol.unh.edu">abailey@iol.unh.edu</a>&gt;<div>Reviewed-by Andrew Bailey &lt;<a href="mailto:abailey@iol.unh.edu">abailey@iol.unh.edu</a>&gt;</div></div>

--000000000000847f51064db5dce9--
