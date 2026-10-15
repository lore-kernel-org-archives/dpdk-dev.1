Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03F1CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 09:13:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01E11402DA;
	Thu, 15 Oct 2026 11:13:46 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 6BC8B40041
 for <dev@dpdk.org>; Thu, 15 Oct 2026 11:13:44 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id BA8F11400100
 for <dev@dpdk.org>; Thu, 15 Oct 2026 05:13:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Thu, 15 Oct 2026 05:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792055623;
 x=1792142023; bh=CIJY8pcqtSWuq4SvF3F0fE8S6Xx2UvHk8KJ1POqNfbk=; b=
 izQvlTK3UEZCtFkNB0ul4OiQhnFJLVdMWEnIk+LzgkrzvwPeZfKiKpzbh9N2AM9G
 RcIFNid+sESIGGM4rdwr1oHyFXRKvYSH/g4p/0OXa6vfmXK6ABipy47PDrowT18q
 3uHxaYr7NjZ7tis1xWeRN3jxlxm7FJ8xuqjAOPCeH4ieAKbed3oCiAYoSG92UC+O
 lAb9RPYhPwQbf5aawnoK7DXdwTxBxEiZ0UW68GWQ64fR3yk1pCqZ2SewoC70R4oC
 3wj6TXKHpRXUcrR14Ga4PjU1htGDakLA7lh34MwAuH0S5R5C421xZGyosaDvKy04
 +NPki+MrvnzXtcR7iymnrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792055623; x=
 1792142023; bh=CIJY8pcqtSWuq4SvF3F0fE8S6Xx2UvHk8KJ1POqNfbk=; b=A
 CUpD3jtFIi5cRLNIoCAGsQirLEaNNhiY95YcaD8UFuGTYUphM0UzgjDcfSIo+lSa
 ZbXqLk4avGRDkaxfgJahUGeJQPRT8mqntH1WlpA3skiSE6nRKn3GyTJuNTHR7ElN
 2Eeby73035AaRUuWvH4MgPRygE9QadAZMf8MecA7KTNvRfxza3yM0jNymt7PF4Cu
 m0fN0ztNnH+UeFz9RLQk1Ag9HTtHirezzM8qazE2DYVtXQ70d4rMxgqO0bbmZSNT
 O4/phIEcpYG6xFKV76rmZowaD4mtsyYrwDE4CYuzuIh4dgsaelnZ0XVz68KqEdFL
 FHOE6oSP7diOVHmxMDGWQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792055623; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:fObaLdL0rKQtym4mpFZZs3YRrXKcPmYmYwn15FJY4HxFJUW
 5QXF34KlnWXEoVnhpGTNx5PWS3uPhviSJkSXzsQY2YA4qZuKICkN9JWsvoO7ny6B
 EJftHOAD26oFp6wflYqDVfMLU6J9SyEvl4VNm0fRKvIJVsVaUSxYAvrRrKFEnlOr
 hLmIRqEcoLIbCz8rKucM9iynvUdIg1XiLn+gd0l6uuagLs3QKNPqMWO6zD2+Sdzd
 IQ6YF/7z0ARrVnR5kBNujaTiZOyGViYfFE3MllyQ+iDRgicUxx7qcZ8Tl3X9Kqb+
 Y1VQCR7ZNEfcLBLnU0nfUflOifWhBI2Sg9ApFKg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:3WBphyOpLDgb/rZB56f+LXkIkJTWVbC2Pl8VXLkant0=:K6uhUly4YP2nJyBkrQ3vt/8XSG866Mrwpo1BVwFRolY=;
X-ME-Sender: <xms:R5nQarmV5HqpiGtXGGGMSa_aMgVCaBBpUVg1rLeC-Cg587nxTp8R_g>
 <xme:R5nQau929TD_AiqrCc0wnEPZiP9OFSRRJmNR0VHqf6i72AUlnK1FabG2dXzqJ8xH8
 XrheEZU2wwocFcaA31HvPR3a6loyby25z1bmz3TiSuiEKDact4UyA>
X-ME-Received: <xmr:R5nQaplnhbWokUuJCArnCeTlV4KaMUXPGyi4ZDEVbkuihUk4fbtefrUUfdEeQYyU99P0JcPrgKEirpkE5QfRVHo>
X-ME-Proxy-Cause: dmFkZTFWZm2LyUp/43y4nagp83mUoZFADw5mQxKEv8zcz383zbIf1RHYqr2txmudQ6vwR7
 i5q9fjYlGGiibOyOyJGWbnuSFRB473xtwWt15nA/hezeWDWD0fEH9qa/pYmIhREh9Okefd
 BJQEx0Kmlxesxm26J/uxlvYD6lHLSsLMZhZlDUF2R9wdbShDmynpYFkUTm518ttbicD0Z7
 lT2Y1+y2ibQIM5V8u/2c477RllGDd80X5ADkuBA0SxG+DeQPM37fGwMbxzIv4l5XDXUx9S
 Mn91kw4rbV8MAslg+U4MbQ5Cw8KIRdbUEQuPdJvoCnjqQYlMmCCLIwwjUMG3PCAGVM9WBF
 6KWAKg6Cpc2OSDWPcnS4DG9wwC+X5SIW66gqbnaEOAhgD8GiY5+gJ+Nr2N+ViT9Pg+JB0F
 AuUp1IbiYNs7UIZC4DJ67HvxLDFyD0pe6E077unBMQt/Sc20Gdu0J/ge8vHWggCM74qau4
 qhiFB3OuF2iCiL63/3dcnoHsytwe0hsqn1EdAafsnmzgDrkmBpkRb6weWiBzDFoKlU6uPT
 xxdQ1AXHN+84LPC1blDrZgiAP+mGAohoU82lbQlLLgDnQjDYSkJkwbnrPrLz9p1VWGUHTh
 KM4Id/0rjMaX02i401GExhmlbxE/VPfLrIXtu0rT+ArCHp/tOVlpRtcKJ1Dg
X-ME-Proxy: <xmx:R5nQar1SG7cWmw2oMxFc5QBrNLnlvfBG5rQwjxs0BXihpeCEym-rJg>
 <xmx:R5nQakoWHh3SXDXrBVIaBoZ6zkgbgV4SOqZmt9tWaAsLVHqhjS9jrQ>
 <xmx:R5nQaocHLv85pcbxf2DjWpvAtYCRBEoEFD4xZ8uOcpBUuadEqKB9Tw>
 <xmx:R5nQajq0EbHkFRbgdsEMvzeyriLafjkBzUG4ppQRReH1j7dDz_OmyA>
 <xmx:R5nQasUOALmOg67GdXtACh5Eyth_RnFKviMhWkLp9rj1AOmkgbILMRw8>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 05:13:42 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] net/ixgbe: avoid private driver include in testpmd
Date: Thu, 15 Oct 2026 11:13:40 +0200
Message-ID: <Q5JnIR46RbOi5z8Dxhadxw@monjalon.net>
In-Reply-To: <0b380d9d-f7e1-4521-a548-9a9163f10995@intel.com>
References: <20261014203435.583064-1-thomas@monjalon.net>
 <0b380d9d-f7e1-4521-a548-9a9163f10995@intel.com>
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

15/10/2026 10:53, Burakov, Anatoly:
> On 10/14/2026 10:34 PM, Thomas Monjalon wrote:
> > Testpmd commands should use the driver's public API
> > rather than access its private structures directly.
> > Note: ixgbe_testpmd.c should be considered as part of testpmd.
> > 
> > ixgbe_testpmd.c includes ixgbe_ethdev.h only to check whether bypass
> > operations are available through the private adapter structure.
> > 
> > Rely on the public bypass API to check availability
> > and handle -ENOTSUP in the commands.
> > Remove ixgbe_ethdev.h, ethdev_driver.h
> > and the now unnecessary RTE_LIBRTE_IXGBE_BYPASS definition.
> > 
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > ---
> 
> Reviewed-by: Anatoly Burakov <anatoly.burakov@intel.com>

I forgot to say it is mostly written by AI.
I didn't review it myself.
Please double check.


