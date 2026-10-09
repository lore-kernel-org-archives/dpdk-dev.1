Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B170FCA9EBB
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 20:36:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8B6140274;
	Fri,  9 Oct 2026 22:36:32 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id 748444026A
 for <dev@dpdk.org>; Fri,  9 Oct 2026 22:36:31 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id D20B67A0104
 for <dev@dpdk.org>; Fri,  9 Oct 2026 16:36:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Fri, 09 Oct 2026 16:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791578190;
 x=1791664590; bh=EjItkXVRB3dhpRUQ0dWdYguT9Hv6CfsoCQjcEjEBv0M=; b=
 UohJw90vc4ZVzUiKNuJL9MwQIIn8oeKyErYPWhwNXNoIn/o/OCijiXkEpQBYF29C
 S3ykQpuUPlT7BztVHvaFNjc6DTt+2Q0IG+4HxkSjFYVXOXTCYob2CAOelHn9JrGC
 tb99vViRslJBA4Q66Hh0tB57ai76hR1vLcyxOp3+O97QgBpawRY8Ovn0GFDKP2UR
 tFhS7v7Q4G1X6km9sC/PAyJuyK9+Q56FNwpuypzhsalO+60gUo0rxR/r28FEugXZ
 3Uf9J4uzqkuInMB9FAv7AwgzkTVdmKc9StiMKgqk275EE0SHD/0cp/TQ2BfxMsRI
 F5lIo0/tIOcenm9N56OuHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791578190; x=
 1791664590; bh=EjItkXVRB3dhpRUQ0dWdYguT9Hv6CfsoCQjcEjEBv0M=; b=B
 udTIJGnT+JKhGO8crUsGb0GJkHm9JOZTNDDstPAnWna9DDasDvCVTncjNYK74vQU
 nCCgYfRj970o7nNxXM4FgvaeR/3mGjk8JNWsMoH2MApr+88dFaY2OKSwlU4YeL6B
 3M4e0SaaOTGBU3RJBcx7sfPrqi8CmxPTXL/Ic7xiFPOlsgFZGrVV/Rg7U57xCZLy
 tDbGKgl3YXKFZYA8XQRP2Tl+r8igMGCh9DlvYY5V1Asz6iPlTreco+cRUFBxscao
 F48LT4Q52jD1zlCIhRWGUsWPamCiN4B0fykcDeWp0Oo6OFk+mRTjwtpZPL3vuLwr
 zwyJMZvkUmx/ZErc1UC2A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791578190; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:TP4Xiz9vHdjpltdVMq2mSv2QHgM1SSD1t+FPb1oKa49+9cW
 Pj4o+aT5patatQBwkb/j8/hKeCTFVbWplkvetV6pDesaJgIv1+8gSwPUXJ4WllaK
 a6BbRWYBKnhYPpKaynTrw9qO+RGgmw3LWaAqa+gTsAnBd7ziJCM/qMj/fkfzdLlB
 jrJcqePqumK9x25RxkhG6lPIRvtZ0uTLSeBGfFiJaTcDq+phZ3mfLtb1IGAH3gMM
 rNp23Hxg12ig5gKZKlcXusiPEXrDeLOrqnkoJnwvPSF351S7qNW0+d9o6kc+7Ic4
 fcgJ4xs1Ia7mBjG0zut9h23PFOY2bO9go+2k31w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:7b9eP7z2Y21ZGdQBeTuKUkeklDVX3ebAY7AUN5B5RG4=:flvZzLIu8GXMQB3/jK5RR16UHyivbYKwc9zlREhbCMY=;
X-ME-Sender: <xms:TlDJaoo9pA0anl5wne7iCPpUI-EcYURzCDzwzDvaUd9qpCDfd7b4Vg>
 <xme:TlDJaq8cG4dbZw7iFVOef7rq-Qf4_WExeYLNf9GDXNv_BJqaugHmAv_GxBzEj466g
 l3idhJ3tCBwTQEh5DVsjy9XCZjDpLtS0y932St9ypuMuIFzeef-_d0>
X-ME-Received: <xmr:TlDJav95oyTweXk4C7uT0dLS4mXwu8ilD6Ptxtq2MdMv6Rih1ij4iI7qSXkzPFE7Kz4p1B1d6CLRmo9ieR5gW80>
X-ME-Proxy-Cause: dmFkZTF4wtyfTDnTSNIm90Obfzb8ISaaGUQ4a07/6V1W9YaQwtNQqjlf2AsNPaFWZppFMm
 YI0YClLCNH30jqIN2mflmOLHgKjgBtK85Q2CUtqROegZq8lmI/Xw4dUcAGxUVpa08d6KqB
 O5ckUaxywy6uWZHPfC7i07aa04Nf5mYFi8Lx9x0bYk9HD/OHEqIRRTvdyxm1p3uMPSlnJJ
 MV9V2oYfUMLUMGqHzMcS5Z4xi6pDQrx+iERnYU7zWxgEDbJQG3y+8TxkfsDDsmMmiAVcYR
 1NegWEuLMQ7G9mOY+GeUSjnq1H7IVOt+P8p6Hd0LB20Xcy0+doG/Q4Uqz00BvKCM6LOQgd
 1qOMi9bVuAmw5i8JIypeXFTevO7PalvU0X8rGWjIlqArF+NE63+gPseAbN5i3320oYoWMA
 0No/0UWZE80s/Dia/emT/PoNL1y9Aq+Z98ZFSZaZOBSDmxSisS/gVuDp47dxshHnKAsuJT
 IPifQw58a/l3bc67YHMXMRZDQ6SeND/FhsERTvsZZoS3dsoHjZVcVpF3UCY1vb4YMISlYG
 xDPvr5YNprENSca+sNbuJRCuO1+w2eHsoCiALJuWjK2Q/6enpNrhzMVhxR4b5MOuT7GkzT
 b6FNoBcgbF0gMUGvI6QRt8BNW/fYQb0eN4PeGuJTLgYudvS7oB1lhAs/rCgg
X-ME-Proxy: <xmx:TlDJahur3erXoLSr1S_FlS4SAdxlglyUE_dY18Bk-V_6UEVGSzSo3A>
 <xmx:TlDJaqoSSYP_6xvoGIgw106l3oHcKVQsNog3YTSvCbwmsbOJZDzVDw>
 <xmx:TlDJamn3c1Vr9dt4htGYyeit23rwDDxfK5V9iAh5egx3a2Tlfh6z3Q>
 <xmx:TlDJamwrO5_DeBj7pe5kg1bT_kaa28pjqG3Fb-mKsD3TKetLTPzEcg>
 <xmx:TlDJahpV5yg2_tc4SOviKsWShPsph_4Z9lTh2cEIlXrL5oR4ucdofyrr>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 16:36:29 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/2] Improve AI review feedback
Date: Fri, 09 Oct 2026 22:36:28 +0200
Message-ID: <0Fp8Ny_VR6y8Ip2GD2TAjQ@monjalon.net>
In-Reply-To: <20260904162454.218213-1-stephen@networkplumber.org>
References: <20260829171822.305500-1-stephen@networkplumber.org>
 <20260904162454.218213-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

04/09/2026 18:23, Stephen Hemminger:
> Existing AI review used by CI generates lots of false
> positives from lack of confidence and poor parsing.
> 
> This still doesn't make up for the missing tooling, where running
> AI review locally or in GUI gives better results. But these
> changes should reduce the bogus warnings.
> 
> Stephen Hemminger (2):
>   AGENTS: reduce false positives
>   devtools/ai/review-patch: reduce spurious warnings

Series applied, thanks.



