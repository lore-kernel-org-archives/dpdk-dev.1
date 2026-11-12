Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDF7606A323
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=YhGFu6Pz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=CA0YzIiQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EBA3415D7;
	Thu, 12 Nov 2026 18:22:43 +0100 (CET)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTPS id D018A40E32
 for <dev@dpdk.org>; Thu, 12 Nov 2026 18:22:41 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id CE3B41400070
 for <dev@dpdk.org>; Thu, 12 Nov 2026 12:22:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 12 Nov 2026 12:22:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794504160;
 x=1794590560; bh=hPrTeOpCuEZ9791vKb72wYkiv9LUCFsXNC34ig+3RgY=; b=
 YhGFu6Pz9cV8OJqwm7PIffGowAMqh7lEOolbUmd2rlxrpiAJ0arjVl60sg8dWrzT
 Ank0ZCGBOiYRarHHcIpvLV3SJYjfKEWZc7K/6O3x4pGI6WCMl2JkBssbOB+u1MiF
 NSUkMGfPvVx7gDyVHjZwFWgQQ+2BnMEaT3lCzeTGXRTb0PSNF7KS5egFi4Qfwgtc
 fUXd8i1U65i+oXZEg2mjR/A5yTwkYLihDgjqyYq+Y5X8rakwgAlkTX7m+QUB+geO
 PB7nUoNYS5kwmP8v4vYs/LoY2C4o4yYqZOHp7IS2pZn8tOUgsUT4aTqrcv8Nrbpp
 Cqtf7ru4cfopIvPNbnjT2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794504160; x=
 1794590560; bh=hPrTeOpCuEZ9791vKb72wYkiv9LUCFsXNC34ig+3RgY=; b=C
 A0YzIiQ/qF55a1Kf19JgIgYynpJodcx8nNGgHFMpXowB22ZP68HoOn3hK12M6LHX
 STP6HLY+1aMirxsPB7RjWgJX2qRbN2iFkJ/AsStc43mt+yrUGgbE+o4kExPgpdWO
 Ymam6/steL6i27cg04nr2Mi3SN+yfxakSn5PG0BSrkUQXFEB7nn3KEbl524MWRWu
 95RlbO7Oer0yl3BUMv9+vU4cKyZZv89iv7ld1XXS2RLktsrwk74TzEAk9VTXPt/I
 L7bMbngONWth03L+H+QNdzOerIBDb2zAUoibJD1jqLb/otZ0TU0RUSstBcH4j9QH
 AFDp71kTu0OAqnr1F0fWw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794504160; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:ik7NpYUXya8FvDjlzhQKgdPgdBryTZFkfTp5zy/lh/a+X6u
 isXViB5/XlILYP7DCsASgnA0nF3NA+B+QqHOdNI8qkIS71xjAPIv4XU3tLde+c+p
 p2KIKkam6LwVj3Ey/amVMYH4DbO6pCkYLwttA18G7tA2wWTBeFwme3A9u3DxfVS4
 OXfkwmjNwOBZLYH4vGxi0shvfk4ZJ3dkbo2k+RURkadTuTv19i5rZSI1XsucLdjB
 l2DvT3r3VkoSxr1H2Ma8DW4XRCQfZ9L7dPYL3QOFjtF0NUN25YzMCU5sKaDfbAlG
 3ZhP9f1CK7U5e1m9ZoUJmNPrpSwVuf2jawccsPg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:q6Y34p/tV3XXySbR7F2r++dXP8i2Cx3r3iAolKG9m9M=:7taJz4Iq6mPcKLP9AAuPoLwIcOHknL0cOdh+DP3k2Yk=;
X-ME-Sender: <xms:4PX1agH_6fan_HLRI8dr04AbW50a5SktEBxGhF6B8OFEo4laoicUtw>
 <xme:4PX1akzHPp4mwuDbGhojGDJrxSu3v-X_q-jqN2mkGEQh0PmGcVBGpBKdARnzt_-TB
 -JMEwPrZFtgWqm4-Hll7lTeq98mHO3iUZZnI0zwwhca9u65jvGmaac>
X-ME-Received: <xmr:4PX1ato2xPHb306P_AsYxDcnP4Ug14mvIhfcM6-Jim4mEmp5gBgx4jnOFWDBvreET0zKurmPjeqkIT5me7QTKFc>
X-ME-Proxy-Cause: dmFkZTF/Fuf5qI76kfoAWgF7UpT/yM5uzMn6ILgNySjFD7YEX1ksfJSV/gnsTS/hoyNCl1
 7+5frvNQeNia882O0PvKzIGGrXnpqC4X9xYhD0cBNfFVT81ooNPCwlsl7PAP8QpeepcxDK
 bdGc0Oe+zfmJPA7ER7y+ZjRLnvSOx4ntnv9mVJgloGHQclUHhsuOojvBMpmQvl1dWna64L
 vq/f+DBMJGIFWg+OEenrEM1Uub2NtC5qDrfpZ+SWzYpTMA9p5p//Y9yp/A2Fx9M79Ry7Wt
 pqf3ymryBwZYyqFMJOobk0IPD9jB6CqTOMMTFXTK7UwlNr1BjH4UyZBtV6opWOmR0A2jIU
 zEAiyOzCi0Yh8QOMKiB3IxD8QWwECr3CY9I2lxqRUrH4hkTl1OCPVT1OE++QfMKJtagDz3
 OzQN++0SIEieVTl7uCRbyfMOs0cjaoQYPhr7vOiypOwVJ9Pl6EhMRgJLYqU9oVfsqATdsl
 qZ1gPVgfGOaSPl9zGy80YOKlvrgsMDsylJakJDRVcUa/4aHuueXqxkOaxyuoeigZfR8Jww
 FtpOhLuDlcrzsTjSzToDZsdiVz0EmL52t7pzPL1psUb+n1awUhpf+ejf+g55xQDGXWRWaw
 Ic+NIfBL68bI6nXcT2HmbUpFZiXtwrcd7XMNjHETXjPUeoHk3lpO3Ah7LKuQ
X-ME-Proxy: <xmx:4PX1amgd-PH9Q5kCp83robrZ6T_d3P2-cT7V9vVeqsmU3knipebVig>
 <xmx:4PX1aiiIAuC6s3CXcsvAm8D8lAR7QCJ3rIgF-yEFqFUe0_TIbAWQ9Q>
 <xmx:4PX1akgT6WFJIEdPoPeQLAmB7QmsP3SDgvUjTm0jkiVUH8Q39DFQRA>
 <xmx:4PX1aqKiBYNxcvEXUV05VSshkKd9VhWLVSXWyO2keYzRflLOtFKJdA>
 <xmx:4PX1aoLbI2_U_gOLOzZ0jequrS7EecpWMrf2dl8PO-RKXFxNvPGQdeQx>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 12:22:39 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Roman Khromenok <roma55592@yandex.ru>
Cc: dev@dpdk.org, reshma.pattan@intel.com, stephen@networkplumber.org,
 stable@dpdk.org
Subject: Re: [PATCH v2 1/2] app/procinfo: fix module EEPROM dump of multiple
 ports
Date: Thu, 12 Nov 2026 18:22:38 +0100
Message-ID: <ro5kOMLUR7iS19zInGPuGQ@monjalon.net>
In-Reply-To: <20261029182033.1738436-2-roma55592@yandex.ru>
References: <e6d262613a145c7e850a526b03070bad38c40a92.1791609796.git.roma55592@yandex.ru>
 <20261029182033.1738436-1-roma55592@yandex.ru>
 <20261029182033.1738436-2-roma55592@yandex.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

29/10/2026 19:20, Roman Khromenok:
> The --show-module-eeprom option stopped at the first port whose
> module EEPROM could not be read, so a port without a module, or
> a driver without the operation, hid the modules of all the next
> ports. Report the error and go on with the next port, with the
> port number in the message since several ports can now fail.
> 
> The EEPROM was also read into a fixed size buffer with the length
> reported by the driver, without checking it. Skip the port if the
> length does not fit the buffer.
> 
> Fixes: 0084463ea004 ("app/procinfo: dump module EEPROM info")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Roman Khromenok <roma55592@yandex.ru>

Applied without the second patch as suggested, thanks.


