Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F7EC43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 13:19:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B52BB40615;
	Mon,  6 Jul 2026 15:19:00 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 47842402C3
 for <dev@dpdk.org>; Mon,  6 Jul 2026 15:18:59 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 6AD557A016A;
 Mon,  6 Jul 2026 09:18:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 06 Jul 2026 09:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783343938;
 x=1783430338; bh=tsVcOwPBI+O1WPB9GG+ux5uQoJvQl+k0XsFepLGsRGQ=; b=
 UkbvkBpZ3DaSxIqIJQUOkUhEkjZzngHVGzkb/soXP+qWks/Xr4WNGdBi9ovJmeWA
 pJpP9fws5FQSZsVLe3K3yhFOyGu9dAnETA6lvHWDkM8FLmP4T6GrcRafKX7eFvtJ
 nGipKIa4wPGhGlBOmdgiTqh4B++kfwkK/EowZ/OmjwGHVX+xlJAOf4TnzAazSFPZ
 AK4wsx9yBiVwb5DGSWd55w+4js1o2LKOPIKHr4LnLSeoqlyEVjaJ9wi4VQYG6NeD
 tjlkmsFA+l9rrB/ZON+6xRdfLXu9TWruw4ssaBNFxFEZxf44sBXSlZWdqzr0QwGk
 /SodaF69IH6Y1+Mp5Ojx1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783343938; x=
 1783430338; bh=tsVcOwPBI+O1WPB9GG+ux5uQoJvQl+k0XsFepLGsRGQ=; b=X
 ca5AUdOEq5vEMWA6RBpxTe44kzwCJATJYuBv+adAaAvyx4MzPe8Lfw9HcnyPPS4x
 1fzzZyziKdA/N8iWZ6vkI6NHinglE+CRHQ8TEcIGVi4Cy2uoO0o8u5pICS8FsViL
 jhouz+mCUqTpWXSmG9xPaUoFS7M94vTTwlErjOovVObmJD8mxZNwN5moc86FNsho
 Z94g2JVxZNgR1jY7Zy9QiM8NRynsd/8NIgqg9og8WR+bd39gO09wxZ3HUEoemAXe
 hkRxdnXTTScHYzwtflwvlqOW1clq2Rp/NPpkoK5TQKF0L4pAIUZIz1gzElsQXl/E
 0oDXYvFbKbmHUIl0sHnOg==
X-ME-Sender: <xms:QatLaiZcoYE_fw2G5DbaBWvFfhBPKK9nWAPCsm2InYPQmItocL4m5Q>
 <xme:QatLaljhFxzuRTZqtcK8rjLKq1EdLKI3j7eO7T8LoObLTLNuaQBZSJyI9EOLW2-re
 iU9Dq0sRpppoxkUy529ShhBWkEK8wDC22IWklxxY0J6PveF1olGvA>
X-ME-Received: <xmr:QatLak4Mk-Wa3jbtGvuTbIAQxy5fryecYF9zfiSxuzun1dTj4QY_Qdr7P_TJpz7RJw5jyuhP_b9Z9KgGry4teg_FCw>
X-ME-Proxy-Cause: dmFkZTFEAkrKrbfIjbpaMCHkoMIS4iwd+z+tSkxfOsXsdvmBJmmSqdqrPBwnSTwxSVW8Em
 7oPE1UuV9bwMfO8/G7N+dZALPFEM87ot2S9MFAhZ1DLKekXR1dc6uL6ez/KNPLGvDIi5M3
 ow5eGztCsMPixxpn83dAm+yznT8V7PLL2S60BX2X5YnH8kvwl6GOkLSL8MPWc0MIW4LNqh
 mHuqg1rzZVIqOy8+NH+bVQXjl0yjd5EwjqmbNKvX4NMlHRyy5/eSPvzq4mGISkz1/rswR+
 Rg6lvaDX05uGbLqjawG/lJi2GbxPX7bFMoaSxTh0+dyVegZ+yTK6Bvaw5Px73wt+VxaGar
 Lzkuf9vyzchqDK4SbyhenKk12zh/29KpkIF+ZouMwHE4TYgvSjrA2BU6/piMM40mFbJXNR
 HriD6uMyU1O4Fp5nzaiC76cskefCK3DQLDVMf9udvuawZfgURL8wmZbcrElFi+zS4yIYUN
 LmtPrCzbvmEgT96XYj0rgGrAS2qi9rQDnMt1jgbiUWQ2Opqi9OGsLt2PUaXJ3TpfnbePCn
 Mjnu8O9TOWiFH6dxdmXM7vIRHSu6nEB2fDJK3xtiOErv4E4Smcpnq4oN7J7uo1S+9TUY6r
 9Lc4nHarfgAaT2SqKwq59mj7BRX8JQAD2Xzvs1kjkO5ksbjqcIMw59Vj/aig
X-ME-Proxy: <xmx:QatLas4RwTs0z9USBHB5pjAhz00FN46--f3aszLEdHSo0bFjKCudSw>
 <xmx:QatLaoe2BWOiyWQ2h51Qv92kddheHkO5wlTpqBBaHyn8MlLxWZJynQ>
 <xmx:QatLaoAPAHs7iCLztbbMMcffJ1LIReNKXKOq1hxhlOQPfAkL7QvKCw>
 <xmx:QatLaj_PNGQ6N3tdXUJtiUaJp7p0vxPVi4HZFrslfeKr_yMDmIDNww>
 <xmx:QqtLajAJgrpiTQ4pPy26Vxq8bgwHot-OsOvQaY5G1cOeJ4xpypPxnbtZ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 09:18:56 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] test/bpf_validate: use unit_test_suite_runner
Date: Mon, 06 Jul 2026 15:18:53 +0200
Message-ID: <lWLnJSFJQo-uhqhRL0AhCQ@monjalon.net>
In-Reply-To: <20260703083739.5aa77dbf@phoenix.local>
References: <20260703152910.80285-1-marat.khalili@huawei.com>
 <20260703083739.5aa77dbf@phoenix.local>
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

03/07/2026 17:37, Stephen Hemminger:
> On Fri, 3 Jul 2026 16:29:09 +0100
> Marat Khalili <marat.khalili@huawei.com> wrote:
> 
> > Due to github CI running out of tmpfs space after adding 29 new BPF
> > validate tests they were temporarily disabled. Restore them as a single
> > test using unit_test_suite_runner.
> > 
> > Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> > ---
> 
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.



