Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3F8C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 01:13:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9809D402D1;
	Fri,  3 Jul 2026 03:13:26 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id D190340291
 for <dev@dpdk.org>; Fri,  3 Jul 2026 03:13:24 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id B6E211D0011B;
 Thu,  2 Jul 2026 21:13:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Thu, 02 Jul 2026 21:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783041203;
 x=1783127603; bh=wdhGpnRPASj0kb7keBSeMKLmGW0dvVFw1B4ADn2eQ8A=; b=
 RkFoxbyHop0+XKHOaxIm/fQzvvlkK86F0oA0UeT+FLFH6E7N1WqjU+jWp+KGVS33
 QI0sTeOJj/PUTwrat1sd1mzJfB4fMIqtWhIEChLzukp5t/splwiaMo2jCwPSQVkB
 vbGgF+8QrwePocGqCHSD3sMQDdJUW/tTSn51jM45HszdPq4XqmmBghlK11GIqA+T
 vgRLh+R5rjF0rF/2X1augoeAEQfcb8obJvGtMZfdakv32Ej8J161D2xdfYdo5VxH
 VBi0Eltm9G4NIMkBcITgl44Dc2nu73g5jgO+Cclq2+Y1x+3glbXDp7fA9eyY5VUW
 5TowQCRkMVXpOqIZ7lSwUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783041203; x=
 1783127603; bh=wdhGpnRPASj0kb7keBSeMKLmGW0dvVFw1B4ADn2eQ8A=; b=q
 VfTelJ+wK3RHFrQSNgFtgVirEb8UCxnRu4PM/RI/MUZG4X0chqP2iDXPNh5H8qlf
 RTAmG7BuKAgonpXYhxGMD/OTyFvjRdTEgLyYZCQbZlUKKobT8O5PyHu2RbWxRCr9
 br2D0cjUHFySY/qPQd3XhdWbRdqs8xOzL4Lh8fTIoOT4ieptkDu2XRXLBu7ONfxz
 Y1i7HHJc2oEPfC5K9F9BMkgULwwaURFbGJMPc2QulkkUEjyiDYjlOE4gJvCaKsD9
 pmIzX4ZJo+8F+H2mzABmNGdu9As0ti++Ne4i0x7kWCBK6DrKp3ZAi467+NGFme+w
 6vCLgi3jqjVDdeetRmFhA==
X-ME-Sender: <xms:sgxHaruu3qg17QniklAZauiNW5naVBtwHmZlH7k3LpMR_uP5e8CWUQ>
 <xme:sgxHaoxU2_ctIdA17F58pepBJhCY6SMBisyPNSEXDCHszWKK3fALQxO3_Clf1KOsX
 _QmKng90e4TGr4ttv637O53B-BUqPOtzaZZyCmwakN2dQON_wT-WA>
X-ME-Received: <xmr:sgxHahjRZ_6XSzudRgv6MxumV7H7LVYQGL4wEFHkBUlW1IKOxKWb7wd9bubwFs6IWV8ZveiauPG8kCqzMth-4S5Fzg>
X-ME-Proxy-Cause: dmFkZTG14gpLt1JETvLUxSmy8aWERrFM20kTOWAn/yJDojGneLfBOcnqaVV+eUsD3ybA+0
 MRv1al32Vxgszpy0WzA7WpEIRtTpPo6quH3pF1UvDkGnInvv3yHrhVrbGOelBlp47BS2l/
 QljvbkcHTyKkq8Ky4g625GjF3cwm6/JgTE+zOQu0Mc4F+N7928yihg9cqTRtVbd8B2zkfH
 fYs1P4vIEMG/tTa3dihHdihTG8y9IKhV+xLWdY+3mOop18aA1QyDoT4P1WR4x5dShDDeHW
 QefaF96lFE+tkkYohVbQa26Clv9KDtI0GrZLBWnPuAYyAomsKM02scWmZW/U2ys0xGD5la
 5xeBS7/tvSi+iYXfJk/Si99z1ZXK40OkJY8qN5vyBCyC/I24RFJEoW5pvhehl+cjhLUcTx
 hFPizQ2n2Y5TguhylRO1PkHWBOUAk8ZppaCtAogg73y0hMAALoELD6gzjdRTZ5F1227CJ2
 6Vu85YF1tkMU7lcfve6VJr1FOBgcOH5Xhn/VCC9P7hvm9KCrihoz7yi4AW65SXB7uzMBA3
 OGecuqCHeWylwfGevLFSfX47AG+mCJWd/IuxGMOKf3CX+DK49lTzrgrPOGFEFmeny3CKbB
 ho8Jb1Ph2okmXB7syEaWHtzc8NTvYw/FJ613L5fqi8TuXtrSjuSVYsNthtfA
X-ME-Proxy: <xmx:sgxHasA2wwJrBenvmgcbNh97DaJo3hT-7HG02YGUwdRzO4wumv_bsg>
 <xmx:sgxHauvFl70CiT05IoNT93FCRaZ9wPzv0t-iRt8f-yRls5OBMh5eAw>
 <xmx:sgxHahaw7ntpZ1xrXnhKwT7JRioRHg-lAzjyNYJrERSu9RS-WhSG3g>
 <xmx:sgxHahU744jv1JOVdAbkPUaPvHp2Q7S2LYDEYNuqSdT3uFtJ17ZvKg>
 <xmx:swxHar-I1bxT1YY83fnMDyPZtCkCmy-P0ehjOQOOHNalYF2whv8kAq4y>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 21:13:22 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 00/24] bpf: test and fix issues in verifier
Date: Fri, 03 Jul 2026 03:13:20 +0200
Message-ID: <odHzwIhfQqmZl51Yb61-0A@monjalon.net>
In-Reply-To: <20260624121800.40635-1-marat.khalili@huawei.com>
References: <20260623143215.95318-1-marat.khalili@huawei.com>
 <20260624121800.40635-1-marat.khalili@huawei.com>
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

> Marat Khalili (24):
>   bpf: format and dump jlt, jle, jslt, and jsle
>   bpf: add format instruction function
>   bpf/validate: break on error in evaluate
>   bpf/validate: expand comments in evaluate cycle
>   bpf/validate: introduce debugging interface
>   bpf/validate: fix BPF_ADD of pointer to a scalar
>   bpf/validate: fix BPF_LDX | EBPF_DW signed range
>   test/bpf_validate: add setup and basic tests
>   test/bpf_validate: add harness for pointer tests
>   bpf/validate: fix EBPF_JSLT | BPF_X evaluation
>   bpf/validate: fix BPF_NEG of INT64_MIN and 0
>   bpf/validate: fix BPF_DIV and BPF_MOD signed part
>   bpf/validate: fix BPF_MUL ranges minimum typo
>   bpf/validate: fix BPF_MUL signed overflow UB
>   bpf/validate: fix BPF_JGT/EBPF_JSGT no-jump max
>   bpf/validate: fix BPF_JMP source range calculation
>   bpf/validate: fix BPF_JMP empty range handling
>   bpf/validate: fix BPF_AND min calculations
>   bpf/validate: fix BPF_LSH shift-out-of-bounds UB
>   bpf/validate: fix BPF_OR min calculations
>   bpf/validate: fix BPF_SUB signed max zero case
>   bpf/validate: fix BPF_XOR signed min calculation
>   bpf/validate: prevent overflow when building graph
>   doc: add release notes for BPF validation fixes

Applied, thanks.


