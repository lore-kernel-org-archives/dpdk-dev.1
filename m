Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC88C98321
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 16:32:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7BDE402AD;
	Fri, 25 Sep 2026 18:32:20 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 6D38640294
 for <dev@dpdk.org>; Fri, 25 Sep 2026 18:32:19 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 88A0B14000C1;
 Fri, 25 Sep 2026 12:32:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Fri, 25 Sep 2026 12:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1790353938;
 x=1790440338; bh=UWlJ6OOLMnnO3/+3UoZQrNITlYISWeGnM25Pef0JTWE=; b=
 W7fluyHO2hLMtbnp8aHc4o0mIOE/48qqvqrbak8w30VamP1YGPYM1VvFDwpEycrs
 Kd+i4kE66bR+5y07cvoEdaDwaZ5ALl+eeIN1TR+7lM/A7euQhNbmT3+2byyDlk4+
 C5D5LUEsupQIp6xdwqdiluvGFL60CLjFZEvwLZOfZLz2LjLx/NYxEcyEeoXUxm9T
 xd7O2TAiSXY+wIh5sVytQrrm5U0lyOAl8Y7IU4JDuBA7JW78GBbg1lzFyBNYZEWl
 YnuXCD6phU119bxYxMCbBeNjp4IHllwtaQq+LhEezwgrNynMKQXBgrX2Uw1Zv93W
 1iKmCa9EywiWNGwc5RS4bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790353938; x=
 1790440338; bh=UWlJ6OOLMnnO3/+3UoZQrNITlYISWeGnM25Pef0JTWE=; b=t
 J+va/e47kXMTZD28fMrfVGHWeRK+ytNRJ9GTzy/cRuRkfhRQcpDBT7DHMWfVehP/
 w9YULWWYLoAYvF5825vV4Upfba+0A8YCorbMuOux4x4xYvZ/fINmi03sszWJouUa
 q0HuqSZAb6U+0Fv3t9h8icDP7QgLuZS1m+0cybVaqJ7EqdZYc2hrsK9D0s0E5JkW
 +71ct/mgKzYCY13GKEpSxEm1S7GQvKRxr/FlkTz5UbiF34vUTHErFrtYvBxJha48
 0g+nL+PFN905kt6j0rqhTb9ewNY3PeA0Yedzqq2J6B+DLTN4IX9ib4WPv7YE6UqZ
 EvNVSkN10OSwAoyDlV21A==
X-ME-Sender: <xms:EqK2akj1R5KEncBQOkotUuBjXJagL5HKI6zDQumuqE0K7HwE-RwfFw>
 <xme:EqK2ahUL-hr5seCegfD5sSfE-E5l4SdtYyzqRRsCWIf2k91Xt2T7FM_BzeRITgzDu
 RBf9V0zmYhJ4oiS_v0QFs5dVN7UlupIeykfkkVZptq40CbchjuOMyU>
X-ME-Received: <xmr:EqK2arNIXGvN_PK-5ImFN0Zbu44YEYgv1gVxqN-bJP6bjIsDB3T0Uxdwm-Sy_fCFqvW87lZDtvPSG8ZcgKDZwLs>
X-ME-Proxy-Cause: dmFkZTGKZCY6CP4bdpjy5f4BzyUSKitNi1Ne4sRCr9q5o+HzemqdpImbKNZXxY231TFfa6
 1pBCsgKhDEt/UpsIgC3UBa8U7I0b/DlLACS2R8Ntifplcett02shslDJ9X+6v8MSa5PAQN
 B6PEByVx8VpG4SclgQGQKSPYxPtO6DpoaU0PWoFznVwbxC/pDQv1CeGfKqSWOMjOk0QZ0A
 B0dUnMCgFhEqCUic6STLyA8Q7axmodUYZy4wJpdU/UF5O5ogBvIWVjspzXbwjbseaNf4VM
 qARKVWbyDJEHmP2OzfpDXRTWevOyYwl3egXgginfxHxMkf6IoySKQih+MJq0IMUfr+S+Nd
 Dif4LK2buUP59vKZ7Ge92OIy/9zv9nMHozpHgMWUcI69IS50uBRlcpOKWgpto6qAguWpLY
 b2mhXiWWCEQsd8Sbp8x1uhqfPCaPYpCjMUVB5QkfDnL4jt2IP+Jm2ggSW6cdMMD4s5Ky0b
 P9/RaJk3MbUI2eRuO6XiefofO67KwwtqSYt1KvIJD1y4gB8vnfrM8oeW3XO1/rHxNfODK9
 5aE2KrUA6Opuwp3HuJ/cUHeWXzz3+jtS+Psz0NErS0PMkfbFfpNUGmeIRgTnP/w00Airhm
 J7IV51rgN2+WCfycTfxMLSUYGMWY/HI0vnHXn42hkfkL+1x7wrZp2FurKDQw
X-ME-Proxy: <xmx:EqK2ata9cZBVdemmslC-46ZH9GtFFtfVPsPxv-1dIXe7d_US-G4OTw>
 <xmx:EqK2anogwnoB55xQMk9z2EOIpcgnQgwxW-8pzzkn3JIIU7oEpXxd-A>
 <xmx:EqK2apbzF1OCnzzC41ZAIqFCaOQqZpyEn0wufWPsBB0NBRqnKL_Tqg>
 <xmx:EqK2anT2tPKE690emwKye0C_0nK-mA2GeMPwTq2tA2BgOu5uoD-2yA>
 <xmx:EqK2akq-0xIrtI2neyRRSEZyIozmCFaBl-o86lI74gHYBdYTAVfUGNqL>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 12:32:17 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Ji, Kai" <kai.ji@intel.com>, Akhil Goyal <gakhil@marvell.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [EXTERNAL] [PATCH v7] examples: add Wycheproof validation app
Date: Fri, 25 Sep 2026 18:32:14 +0200
Message-ID: <Uoji51ajRt-6kVG_ZXgD_Q@monjalon.net>
In-Reply-To: <CO6PR18MB4484077A45CBFCF6CB562E20D8812@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260923105003.2811322-1-kai.ji@intel.com>
 <LV2PR11MB6045AC38B49432A2FEA9C20281812@LV2PR11MB6045.namprd11.prod.outlook.com>
 <CO6PR18MB4484077A45CBFCF6CB562E20D8812@CO6PR18MB4484.namprd18.prod.outlook.com>
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

24/09/2026 20:00, Akhil Goyal:
> > Wycheproof differs somewhat from the existing cryptodev test vectors in that it is
> > an externally maintained collection of JSON test suites covering a large number of
> > edge cases and negative tests. The intended usage model is to load the upstream
> > vector files at runtime rather than embedding them in the DPDK tree.
> > I think the existing examples/fips_validation application follows a similar
> > approach, consuming external CAVP/ACVP vector files rather than integrating
> > them into dpdk-test. This patch follows that precedent, with the goal of providing
> > file-driven conformance validation as a standalone example application.
> > I agree that the documentation can be improved. At minimum, the .rst should
> > describe where the Wycheproof vectors can be obtained and reference the
> > applicable upstream license, as the current example command may give the
> > impression that the vector files are included in the DPDK source tree when they
> > are not.
> 
> Ok, so in that case did you consider integrating this app into fips_validation app..
> May be we could rename fips_validation to crypto_validation and internally have 2 modes - 
> Fips and Wycheproof? Like what we have for examples/multi_process?

I like this proposal.



