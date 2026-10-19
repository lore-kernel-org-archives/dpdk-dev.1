Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB43CCF2D6
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 11:27:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44D4B40659;
	Mon, 19 Oct 2026 13:27:13 +0200 (CEST)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id A53EE4064A
 for <dev@dpdk.org>; Mon, 19 Oct 2026 13:27:11 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 147BEEC0095
 for <dev@dpdk.org>; Mon, 19 Oct 2026 07:27:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Mon, 19 Oct 2026 07:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792409231;
 x=1792495631; bh=UPBYh7Qrb22ETDv60x7uuQW7Ube/rKWqFdOEN2iaFgI=; b=
 S9FenPTHLFJR5vPgtGZs+xdQlwUMF8hO9BYs0oqcTNufgzF/CZjXUwQOnfdEtjGN
 6dLr3R5vD5X9JRiLEbidaIHRIcEdWki8f601h443OcmG7y1c69rwsFCG2keqbryu
 N3JLxN/svROUS6CIx6fpp+uGgJCLOKyDHP3XtYoOL9+XRlpUuWbRrqt/VSAOb3v8
 ARgmY2wiimzW1fP8n1J3d8f0QaIOv+SmiTeWtUhpm5tJZia1hQZ76V5iB9Sc+DrG
 N7KyFUKebWKTyONwfmWzK9cX1PWFHpuZmQyy7TCFl9e+zTmPYGXasoAdjCf8tO3y
 cZl2bZwzspfxvtPSQDovhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792409231; x=
 1792495631; bh=UPBYh7Qrb22ETDv60x7uuQW7Ube/rKWqFdOEN2iaFgI=; b=e
 RjpqwYYdyGW8bKEWXTrtWC01bqgijqHNNwmvZDPUBhUhhrW+wuKqrxxQSKaCtZie
 rGA0h4FBQxv9yUP38LfQ8x7sblc6Xk5EwQXGk0CqcFP8+3feGoY399lzJy5vsRoW
 jZ96nrRjKZaof+bhoFaOvLKyKuDduactv5m4/Qw/f1bL4yYPNRCUlO6WFVsDC830
 DkxXm8cpAgSvyW7JVAfPlLp8g/do2nsZFwUSvngOh765fP5N3i7gTHBrIcUJvKsH
 BnN4CCJXxyQgrEf6nJ6LnitM3sBIOTfhFPicW/X8OAd2UvDGW5FbZeMBNjmZqSrQ
 hBgbz7/Unq/D+C0CnXItg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792409231; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:C4wlJfeWx4sHfoXJOr5cAg3xEMu2/gfmUXfwgUN/8CneDJp
 ZmuMEmS9xLsN4vB0PmB3Yz68BjHcImCxC7cCXQRyQs2ybS/4phAxaC92Pg1PN5gA
 wnin3DnJ4ZdMhr1LQEhzvb0IfwsSmxia3lJNfeCWwxjh1+P17w1qZTI3hwxVhVl5
 XskpGRNEiIIDLxfdUMWISQECs6BWGjRkSk82cfQYxgG2GKoo0rRy1dtjqlLrWrz7
 vTcZvUI9LtnBz+rLZpxwjck1GEeg8MFH2rQj1yhS3f+eH3B7lRllctMt78LweQgP
 fAMmpTkN01RPYYqCcH7u+3uH4yXfwt4X87nJVCQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:IL5sWEw0g8N7ItZc+IFYE0EN2sN3OA0epBo8BCcpX0U=:UdqJCjyuT2ljx529Yg5Q0b4+Etd0K/Q9KKVa3eMNcEM=;
X-ME-Sender: <xms:jv7VamjWctixdBLk9uTWaDUC-6WORAeczbfaLgvGWdrSiLhO4H1qQA>
 <xme:jv7VarWl_sqtS5IFzkz6638hQXuOi-P3o54RtlYRpQ8bpJh4DxaBcKpjeHStEqSc-
 OJb4r2P4IiM5NV8BHRWAINgb29LcYSSkv8HoBQuyeeiVUoldsnf3A>
X-ME-Received: <xmr:jv7VatPevcvXh-ii_xiP-fUtT4omgD_rmQdtZzoO1AgQ2SggNoJD39qrdq4oUHWKUavwMd5uLk2r8chMmGTXuS0>
X-ME-Proxy-Cause: dmFkZTEj3pdGodpeFcMBM3ikpviPEzHTlGr8uCeiowl6iX5ggjacTprqB8YNZBXooCRNxo
 0Q0yM7O4tKghHz3DGWsfwa8k20+CIaURSEFP1vou7C05ENAF0GfnXLVNXwDO46uOaZrlJ+
 qSUChrAnDFOriB5sKGD8o8DlsUb6TOxYsdaOWCeJYyVOjenMXYFkEGIUbvvoOO5S6781hJ
 t90hz8jde+u4SrzSUcxQn20GSdBGTN4ahpR3tb1weQTG7pP0PiX2rckC8GvkAr20vHuNCo
 fbrAjnomuMtMS9O0ytyk7ITApD6Oj+1E+qtZeajvT6d6BaY0a4ty/RNoBKqxH0fwaB/pVT
 VXJVnWpEg9teuPATHwQEu+GSCnl52NvyFsCZtryVRzWP4ipSAMjnHyzZpKL+CM/X0cm6Q3
 YQziyBqxJrYsJlYmJieG93DeHejL1mrigtis3t/8++2kzA95iDL1OEtQsRWkO0xjsM+Hl1
 5JJs49nRH1Elj1rUM5mSIwTu6I1IRlcCPs3t2EiJlHhc8pk7+th1M0upne8UYDIU21WgST
 mHckyvs9I+5t5jm17AEOtlsT6nzdz54WbTbsRP4yJxI8OyQlnfNGnipddS19aEQBHHnzfv
 ONPg7e/7EKogUwDz5JA3Vc1aiwgz+6l5f+CrKmjYNRQ1BHtTAXzEnBurLULA
X-ME-Proxy: <xmx:jv7VanZpX2wPqShnHL5irJlE-uSO-tQ-hUmGQIT2AbLEqw-RLBxIqA>
 <xmx:jv7VaprzpZ6cxo8bj3hsg325PmtRfUGwHZsdDBiDKeybRbTjEOODfQ>
 <xmx:jv7VajaYR6xU208z2DWbZvZEsfX5yKqXvaIeB8Ub5N0yc2gIXZ596g>
 <xmx:jv7VapTOZT0yrIH7rhd-5ZsPxLOLf8rlN9MS7FJVjvbJ4ImIC_Qh2g>
 <xmx:j_7VarCmxwaSH0mo-Oo9JtqZ8aIy5FY2n6YCg757dv7tkPAY-jmAg7Yw>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 07:27:10 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Radu Nicolau <radu.nicolau@intel.com>
Cc: dev@dpdk.org, Kai Ji <kai.ji@intel.com>
Subject: Re: [PATCH v3 0/4] crypto/ipsec_mb: add support for IPsecMB 3.0
Date: Mon, 19 Oct 2026 13:27:08 +0200
Message-ID: <8OA9ksWHSu-USgHcEeFFXg@monjalon.net>
In-Reply-To: <9c02cf79-6902-429e-a67d-e53ae203bb49@intel.com>
References: <20261012135947.1895429-1-radu.nicolau@intel.com>
 <Fb4CjKFWRziKn9hdw7IRLA@monjalon.net>
 <9c02cf79-6902-429e-a67d-e53ae203bb49@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

19/10/2026 11:25, Radu Nicolau:
>=20
> On 13-Oct-26 8:41 PM, Thomas Monjalon wrote:
> > 12/10/2026 15:58, Radu Nicolau:
> >> Intel(R) Multi-Buffer Crypto for IPsec Library released version 3.0.0
> >> codenamed T=C3=BAnel Pablo
> >> https://github.com/intel/intel-ipsec-mb/releases/tag/v3.0.0
> >>
> >> This patchset adds support for the new library version and support
> >> for the new algorithms included in this release.
> >>
> >> Series-acked-by: Kai Ji <kai.ji@intel.com>
> >>
> >> Radu Nicolau (4):
> >>    crypto/ipsec_mb: add support for IPsecMB 3.0
> >>    crypto/ipsec_mb: add support for 256-NxA4/5/6 algorithms
> >>    crypto/ipsec_mb: add support for ML-KEM and ML-DSA
> >>    test/crypto: add asym test suite for AESNI_MB
> > Sorry I will give a defensive NACK
> > because you never fixed the problem with the Arm fork.
> > The crypto branch is already not compiling on Arm
> > because of your recent change for IPsec MB 2.0.
> Hi Thomas, with the latest changes and removal of minimum required=20
> version these patches are now compiling on Arm, are we ok to withdraw=20
> the NACK?

If they compile, yes.
What changed?


