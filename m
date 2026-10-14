Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A294CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 14:42:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 870444042C;
	Wed, 14 Oct 2026 16:42:22 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id E788840144
 for <dev@dpdk.org>; Wed, 14 Oct 2026 16:42:20 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 8B9D0EC0197
 for <dev@dpdk.org>; Wed, 14 Oct 2026 10:42:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 14 Oct 2026 10:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791988940;
 x=1792075340; bh=FavQRp4gF/vKrNG1VexVj8xNc2IrYDXwBajn4hv63DI=; b=
 ASbiiHNo+gXxXG7I58excTZdgN6t/GG6Bx6p+RX7nUEL1tIDMStsjbKuZ+Hcx3vc
 DuOVRDLBfne2GPsN6UqTuHKd6hpx9zhoqsNlT6PCSoSJ8j6GhDGEpv7rYg903c4D
 8U0n03T1Umwmdj30JsUdkx0BKvDAblwDVtgBGgf8BTHx36MvPkWaYqv8umbdFxqS
 gB6sROP1ao3+e5B5w8/ZIGwV4AAHgEyhbbiZ580fXZhZ4f/CJedKC4MPKKb3Xnf7
 +iTaNYNfZhwpO7L6L6TvWgPl68F8xToTt/xjGyniGxmeyd6G07CSb11R9KBE008k
 T7Fas5z5ltjTRGZFLSFbZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791988940; x=
 1792075340; bh=FavQRp4gF/vKrNG1VexVj8xNc2IrYDXwBajn4hv63DI=; b=d
 1lx2QKpXucI/s5WoJcGNN9CFiUZSAzeo73BjzG943V09trGufADA7YRFH3l31knU
 k4te8/45r5Ya+kquOc6iOz5mitShLKoFwfAHoCp6KRUXzjyOXIqPxBGEc2GBOGNb
 7VQnbN0OK4hd/K6aRqDg1Yiu6E2e53vtFoRo/234PZCBA9FMXWZqknS53vMOCNFt
 9wBAROgsc1gRTwFxoC7AU7umOSqVTZ0yNsvK1QK890adPKqdeD4f54SteyRr3cKD
 ncyoaG/1NVQKiKxK6X+8zgZkJ/t3v4w47q2fhn1Qn7SlkoVvoSus5ZBDQazL51rb
 RcDMQHjMR+mbcjMDGS+AA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791988940; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:gBmUtymNlkQ09uAjX7w+hnpqORy66HWb0Kww0b1y7LsyGzZ
 UxAbjIklPVHQCNGgEExoyphxycJblMHRpIMy5N3jN0eE3yaPSMlMwC3182Y/a9Q+
 6RnQqKTm6K5YlwwLRiN2WYchxXXK2wVNK0D2Lck/g0zYOxQHMVrSIkxQ5JZLekxL
 ydTPSLZrkLpZ7KptY7fL8dXeQHEDN0WBjt2VOSxGmZIm+pizysw0bUJMUrt82sLT
 jjGRqBCd7Mq1ghi8UEONm2bjwAgM9gducccyLUdtHRoQvE5b2qtZaxoUXGhMl2+S
 rmL9zCQnIoCkOMIvRSXTGhBOEZGy5EPrpyVhRRw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:zqg0FjanswSa2jQh03bxwKa/XUyf2fQY4PBOfKgpHak=:o/rbk9apHo0YLZY3YFBgs+JFiyaaPxO+HsFz7HyLnzE=;
X-ME-Sender: <xms:y5TPanKDpcYo7f3EfFHfztA6RZiswF0rAhUc68PnQblILsogcqO9Zg>
 <xme:y5TPam_O2g7sNMuloGrvNNRK0HOg8sB2kiE4OV2a8170CBpHyS1SbdfCc96rb-sCJ
 iaut4e7sTD2azqXs0p83S6V7CJIMgEFeRdkBin-nEpI-bMQ5BT97A>
X-ME-Received: <xmr:y5TParHYRkH0j5okyNXDqWe72hzK4oI0-L3EXWrW-BN-0JFqZCFC5GI6flkABwPIpdMH0CRdUDUQZkyP-uPrWow>
X-ME-Proxy-Cause: dmFkZTGA/KxbXn4TLxPCVWqwJYpfsUtb08pUj7fFJnXlamhcRELkjuhRkIHEIUCh5qxN6B
 Vi8MXJJEhWH3itJkazw//ou7xmMIogm6KQAleZaHkOLlZ45oOPPe6vGAXoW31yvQ4simP4
 DpneAfaEGxcxtt1GQ3pr4y5MqJc5mmS13SnWliDXrZp4YYPHwP0iNBeGZ9k6sYQ87VWuur
 nyodGKsKsCdVJ+byiZ8ifEg3chA7XMZiu0ZfRxEvQbVf+ngpk/0duRBJf22lByNm4wF6gZ
 VRSqsxBgIV9ZTAjC2pWJlebDXysQ0KoNd4vhfxBYDmqJdpXmQupiTZDKXkaheVxDMb1jOc
 LlmSeJPlnJp6UT19A1SaG96VYU9LH/vNGlUCCMQDIZ5v3mDlF6Bz6nRk7KsrTwU/sti2av
 jbuGPQJuid7/B7gXf3ibNc05uT+Y/KURh9jx/LolrPdt0f5eJNbjHXPVxJpCf1DwSVgW6U
 dirTcbZc1WVmlz+v5/ydWLAjSnVHJWRESUmJ/b0JfLaVKR/jTRYa8jJxRNDs/ggeis+C3b
 b8pO63dF86yZYSl2ngAmpvXreD7jwlBL+zqndNeqADs0Pyc6pxXV/rgQT1y4Ypk2csSOrM
 7PcgRI7Heux4uiiyLtlq3+hLjNeJI8A43uz0dBE7t7x/A01dMbklygxNA3Bw
X-ME-Proxy: <xmx:y5TPap6Gs-W-1dMSg6NpSYDjREFrHxprod5JmXa3StZcfT49EUXCAg>
 <xmx:y5TPasbblHyN_HzV3d79o5r0taF_5SRnhsO0BXHn4EJxmDsQdXJf6A>
 <xmx:y5TPavhIXELeu_7N58qTNf601xEml5Po0KPQOGjAwnjJgM1IIYXWVg>
 <xmx:y5TPamfvEkkFuvJCZoQ8qS47uPJ9V1o0vw9uJp3I2PN1fdSsMYISrg>
 <xmx:zJTPagwuCw0i0jXk-9InTK0lI3b_Uh4fLVsN3FueN7d9qAXGQQbDi_kO>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 10:42:18 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Radu Nicolau <radu.nicolau@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "Ji, Kai" <kai.ji@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, David Marchand <david.marchand@redhat.com>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 John McNamara <john.mcnamara@intel.com>,
 Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, jyotsna.chitri@arm.com
Subject: Re: [PATCH v2] crypto/ipsec_mb: require minimum version 2.0 for IPsec
 MB
Date: Wed, 14 Oct 2026 16:42:16 +0200
Message-ID: <fjUyopQLSkieZRyFov00PA@monjalon.net>
In-Reply-To: <6ecbe3c1-0925-4392-afd8-53c777495175@intel.com>
References: <20260811112636.4106950-1-radu.nicolau@intel.com>
 <1ZyWCFPKR3SU1pTJ1PHaEw@monjalon.net>
 <6ecbe3c1-0925-4392-afd8-53c777495175@intel.com>
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

14/10/2026 14:44, Radu Nicolau:
> On 14-Oct-26 1:16 PM, Thomas Monjalon wrote:
> > 14/10/2026 11:37, Radu Nicolau:
> >> On 13-Oct-26 8:51 PM, Thomas Monjalon wrote:
> >>> 24/09/2026 13:18, Akhil Goyal:
> >>>>> From: Nicolau, Radu <radu.nicolau@intel.com>
> >>>>>> Increase the minimum required IPsec MB library version to 2.0 As a
> >>>>>> consequence, clean up the aesni_mb PMD code.
> >>>>>>
> >>>>>> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
> >>>>> Acked-by: Pablo de Lara <pablo.de.lara.guarch@intel.com>
> >>>> Applied to dpdk-next-crypto
> >>> 
> >>> As usual with Intel IPsec MB, it triggers a compilation failure on Arm:
> >>>
> >>> drivers/crypto/ipsec_mb/pmd_aesni_mb.c:24:32:
> >>> error: 'IMB_CIPHER_SM4_GCM' undeclared
> >>>
> >>> I have to drop this commit while pulling next-crypto in main.
> >>>
> >>> Please find a solution.
> >>> I'm still advocating to merge the Arm fork.
> >> 
> >> Hi Thomas, the root cause of the build failure on Arm is their library
> >> fork which lags behind, being at 1.5 release which is at this point
> >> almost 3 years old.
> >>
> >> The only solution in this release cycle is to drop this patch and rebase
> >> the ones adding support for 3.0.
> >>
> >> Considering Arm lack of support and contributions for these PMD over the
> >> last couple of years, the only long term solution I see to avoid PMD
> >> code littered with ifdefs and supporting very old releases of the
> >> library is to drop the Arm version altogether.
> > No.
> > The only solution is to work with Arm.
> 
> Indeed that would be the ideal solution.
> 
> If anyone @Arm is still watching this space, please chip in.

Adding Arm folks


