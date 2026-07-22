Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C22C44536
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 12:42:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 671F740274;
	Wed, 22 Jul 2026 14:42:02 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 6D7D840270
 for <dev@dpdk.org>; Wed, 22 Jul 2026 14:42:00 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id E81521D0000B;
 Wed, 22 Jul 2026 08:41:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Wed, 22 Jul 2026 08:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784724118;
 x=1784810518; bh=6pBU2C+WIwMxAuU30LSPjFgbyxgrn0wXxIudJQ+N9e8=; b=
 Gf6QpUnn/ENtA/iOIDkF4ewBZHP5XejcbxHGuxOn5G25YEh2mQqSiLotyKbMMoSE
 e36ySuutNqd9iYQ7BwQ4QCtojLmZPfZaw2vgbIlsvCTyVjlmuSvgRud8dCJ3BoMP
 x8Ba1YppkfzcUYvsUB7EAmwXsjZDTFVaT0xYDfCNpWWNNvVpPfqi8HkWzXF7JQ05
 OuK738cvgSCyTqwKDGpqrgw55nJXuTHwOtmMm5FgL53ajTXyG3GLtv6c/AJUPaeQ
 EE3YJHT86L+n+mnReQpMHcn8l+dV5BRDPzZLM+vjuh3C35SGIDAfQ4/8B+Plp+5d
 /h93moVv3zOT6KBZqZfeYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784724118; x=
 1784810518; bh=6pBU2C+WIwMxAuU30LSPjFgbyxgrn0wXxIudJQ+N9e8=; b=O
 dbVDuFyAlQTukAUHkM9sMwTwuA+/GS0JpHlHZ3TQeKI15RQ7d6/MqGyA81y1/EUE
 jCXMGNhuH9QwBRbDUmLucMYz/yS2HrsWnEAJkoGW1Z5Mgk1fH681S8Ms5LVLFjBs
 DYYaTXdb3B/3uI6p7O4HViAGsNIiw/Vl+V+tZjWHzvRVIqKLdawdJhAf37AHkl8R
 M+ZY/MGvpntydzjViVkygvggpu1V/k+y3PBpf3YK1c8ojFE9mVO9u/zyZwWIoaJY
 YIKhvMUmEKcIii02llro+zxmscO7bxqqVaTi4yVxzVnc6mmGraj0bj0wtwqBek1Z
 rAAkB3tstLzljMgt1mJNQ==
X-ME-Sender: <xms:lrpgauVYZ0uEncLtHsn6CwBVaNHKiltLMZLQlsb8_GbWeeyfHNhVZA>
 <xme:lrpgamDlkMxqbKXUlG6IGwm5FotKyrVr_Q7-fKV_C8KPYF1dvF1GOipoC_Oj7HtjM
 FcgqkaErseUVPx4hKjSMVeSObx933duWuW_xiYQWbthlnHWsS15cw>
X-ME-Received: <xmr:lrpgal79MITmJsgn6BlsGPpWUx3GFAwA9DUC1_TjZxOejCFTfaFRWbeyfntRNcdDEd9njiWIHUrzvgTmSRO2xhwv_w>
X-ME-Proxy-Cause: dmFkZTEtGhMGAwCL1B5VtO8K34q2QuVVm1KEy33dIRCpAbl768uNKOVLBc9j3rF+qP6Mfq
 L5Uw98WHys/XAZQ71Hr6GWDy4S6G8BA2SZRb9WEKnJ2u7gz6jmfFGzYXtHOwgx0Ln8S5oE
 s7ILt0jv4INtYz5wPvYRxYweshUM14zwyGQhkoDX31wr4yHEyypjnKRDDD23CVxmFRvJwU
 u0CpiRjnRaXYWPI+5LNSEwkULqvJaQVuyOrZ19/bpymnWDusfCbNQMqleNWg7VY1dxE/7o
 Ao7HZGEyWmCoNTVDep5uK/X6LwZVX0MnG9/GmSHlXYl/roYHfFdzKc76tI2WQG1scXeAtz
 cSudcZGfDK0argW1n5iBhoKj+N5+e5TzjrtUuPBgQkIaviBKcwLWvGDBKqqe6OUSaSvW0x
 lKxZgcJfqlBBG94p7xNUFz46USdEr+oce/K3KMA7meB1089nH3xR1OP18aRo/tby1d/A7S
 k0HcXHGndnNiDE23LIzn8WrZO5yi0xdGnyKJBZy7Yp3CxKFTBqxYq5ov1a6TO4AaCPdvmS
 qLeFO1JNPw4oaqQPYED7FbcUp7eBU+ZJDHwmw3/HjUp+ZeWigbQSwGvy+LaI93qX7DC9ic
 s+RdpZzsHLx4n/l58Oq2vvOx46R+hbuhNgwow+KkIexkFklrdMv/ANB2ifRA
X-ME-Proxy: <xmx:lrpgapw7U35vUHafDp0AkKtHi_6XDeeemDEHQii-xKrCVdveUCyPZQ>
 <xmx:lrpgakwc4W-5QO1EnbzwvOT90OU_664kqYmBcnAmbI0fb9ZCKp4B2w>
 <xmx:lrpgapx-9mXeczztz-fMX8mM3x9VyfQxWZNOD85yZKEELarXV-ZBpA>
 <xmx:lrpgambNmRQ8QpyxZIjWACpPUOgMC7eydVPtfBKPaEfz-Fh-4BfSPQ>
 <xmx:lrpgarKjHXH_HK1suu4AlKr5iiItWjzTrruEpEz5tyJTLXYt0C0meGG4>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 08:41:57 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Ciara Loftus <ciara.loftus@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v2] doc: add deprecation notice for iavf devarg auto
 reconfig
Date: Wed, 22 Jul 2026 14:41:55 +0200
Message-ID: <mlhkgerPRiWE9pm-OyoGXw@monjalon.net>
In-Reply-To: <16acd53d-6d66-44b5-acb0-feb495c96502@intel.com>
References: <20260715105959.2216756-1-ciara.loftus@intel.com>
 <20260715122045.2256082-1-ciara.loftus@intel.com>
 <16acd53d-6d66-44b5-acb0-feb495c96502@intel.com>
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

> > The `auto_reconfig` devarg in the iavf driver is enabled by default and the
> > case for ever disabling it is weak. When disabled, it means the user is
> > requesting the driver not to restore settings (unicast/multicast
> > promiscuous modes) when recovering from a reset. The use case where this
> > might be desired is during a VF initiated reset where the user initiates
> > the reset and wants the VF brought back up in an untouched state. That
> > scenario can be facilitated by extending the `rte_pmd_iavf_reinit` API
> > rather than relying on this devarg, so it should be safe to remove the
> > devarg.
> >
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Acked-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.


