Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29192CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 19:51:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FD81402F0;
	Tue, 13 Oct 2026 21:51:45 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id D2295402E5
 for <dev@dpdk.org>; Tue, 13 Oct 2026 21:51:43 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 5454F14000B4
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:51:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 13 Oct 2026 15:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791921103;
 x=1792007503; bh=sNIOKezi7+qF43j5U9i7hg/ArtmmubtCDY3bz49gUB4=; b=
 Y3cRImTGk36RwtmX15pEx/cSPJEWc6ijK3b7nM/KjAKCnrAwpVUX01AdNUoJeO+I
 2pMAykhl1hy7ACHZQjjsaHRZPsmxvk5FCicpKeLYrhHsq48cSxTJCIOWLcj5XR8I
 6nu9+phAAMNjU0fsmZWhWA/2SlVBdZ5EUsT80A4n13yZbBR+egWNo9QmX5psvg2F
 BQgP3hINNW7tBHOL43WIoQHcPtNqdjaoLW5mXrNI8/2bQGcAt00Pd9CNJODpeMZ+
 F4QoYS7Kw6mOWY3tfmIAN8H8Vj4FgZTphiFW4CFATSTtCAvPooaCHYRWDwjYFl12
 w7ACRTznNLUPfVP1U4NHww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791921103; x=
 1792007503; bh=sNIOKezi7+qF43j5U9i7hg/ArtmmubtCDY3bz49gUB4=; b=Y
 z3YTqq9qBRnk3cdv6x97A/cFkjaAodI3yjYbwmuprLvzo0i2we9GOpJSP1AvNod+
 J2urwmc8a4myhhIqDpTbN1NgqYu281q5Ch1kjs8FLSXNFUosE4cb93TnLJVuhPWu
 6rKBj3yq9oW/nUzZDKQVTFw3kiLauhywnHKxRyA4+/S/66kXKpI0C9gO+7+1Uu0U
 ShFWI939LDfOO6JyHpQXkJUMIJGMUF9zfDo2bXXg+MHnFEr9kptFZhzlPuY71OtS
 qDxl5HwGxcv8yLilN8OYd/RR6G+v68vGQNH9KVmO31puBmuBcTCqzP8mo7/GmY4S
 /c+Zan4xptU0ZKg5iJTTg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791921103; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:FRoegIBjDUCne2aUyzhBZ2Pc2yz/uMnszh+WcOpaErhebP8
 UXJsn7IHpFTZDgzrQMZlgtaoVnwkT9PUiIop1EF5Us1RQHVRCsbGZtsjG4XzZptG
 sWXgU5UEf4iIRWfciSITJ244bMgu7Hx4kKFpKTvvkGnTF0NRL+y8bkR8mL28BRgF
 D/V+r5Z+R89dRxgmFYZlUsFsOR7VcqByoxRH7vCAKSWEtMm/xNUCNElWa1QWq5rQ
 dKSgV/lR6gjsg2Ty4H37R5tFKRzu2z6fCtnkRSV/2GCRYnVnqKpGQ7Uo/zkq0j5a
 KyLAzhBIkks/tItYgoQRQm0NALNbZSmtPU0Gjdw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:vJB/gE94KX4zH9abB5CI6Pyc3QuPmFQdoCpQuGBWUgM=:3iomJa9qyB1y1VBea/uILDm7Nl3rTNZWe0Efl+/+sY8=;
X-ME-Sender: <xms:z4vOalR-G5MIHvyAIkTC0Oe1XMkcrJX2rzm38YDZnQUwTmEmiPQKCg>
 <xme:z4vOanuboKedit5QLX7CsdH_rOfpzuljishyY_-Ot3aFWiYpTNqsOzKTQ2sxHejIy
 ZHhEsE-xkNqQfQ9pz463cV3Ttx3-qpaUKdPYicsAPe75gw2tPU9Mw>
X-ME-Received: <xmr:z4vOamb9rwCGOh1JJJMBz2Y5WA_EROzP3Y-plJCpSIt5xymaUfGBbsK_0VyPI0_2YGSAMJJ7CiUGUtX64HB-ltE>
X-ME-Proxy-Cause: dmFkZTF8IcwbKxtiXMaq95j8tgSeFxMPxh/B1Ajohk/0kTHWGoCpwoI+246J3uy02D84Yd
 /+yxizvNBP6OaXhqA6Bagv+nBnKsl7mKO1bc3H63q+h9H1EGBPsN3rTbwF6icfo/A79RXH
 EkRFlwm2Wq8CZAtO01zXlfrGpdg17rDJhayunFqQHRlsBZXuoBdrpEP1Qs4IefMEedbrgm
 d90OBvtJm6LgHNObSJG+0Me2WrWuXOdbkQXEK0eDk8ZZE9hF/tTNdcp7HSBUAQR5RA1ZBv
 WDN0G/t6wSAdBSUYCh6HK64As/xrIPYAmxwkyZHUYHr5wwei82zlpAUn6S8Z26Gyjd91rk
 6An8SwMsG3oJicINQ5HzAsn3xzOOI36L0yh+0SqTZdqFDdQQJEm9dZ8JOZoKN0ehXkRYAY
 3Tfzh6SEVYbz/i9Tj0pAXFX2/vHwLYsb1Ozh7ym/cvy2qI5I8PtPL5cJYDKDcbIbBJyk8B
 m7hszVhMymyF6CHJNeN4aPHO5KMZ4MwgquvkNV8SwOPuV4Aio8gNVnnaEMwcY+6/8PxfzM
 L+4BX/6TckBwTnNWOxyHxevoFP6Ja6vymSCCGGAZEdP8Hlh3BOCRIe9Ar6CluU98FNmVTz
 2/A2fiybV+l+mGwjiwwbn4dzcNEz8ACW478VICvqT7mbzGrmcopyHYgnR21Q
X-ME-Proxy: <xmx:z4vOatHJEW4ALmod5sqK-h9VW0bZRYaK757qA4GvRdv5W6pczNSqMw>
 <xmx:z4vOaqwOVGzTN7bx2EJAKnhQTfT1OnzL0APKrb1elzab92gWi6rm3Q>
 <xmx:z4vOavk2djcvC0glHk-ub8PRG3JJlujd4O3Wy2INx_zXTnEEmpd8Fw>
 <xmx:z4vOajntutSrU2c-riDjKWweF1Itj3VknpO1rj2Iu2GTTMaxXPSCqw>
 <xmx:z4vOalIe7SDcS3k9YuRT9WH9LMw2qxksM3qXAiLTZPAiOpCgNvy5t7LW>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 15:51:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Nicolau, Radu" <radu.nicolau@intel.com>
Cc: "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>, "Ji, Kai" <kai.ji@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v2] crypto/ipsec_mb: require minimum version 2.0 for IPsec
 MB
Date: Tue, 13 Oct 2026 21:51:39 +0200
Message-ID: <0UZYeU6OS3OoPauzypyoiQ@monjalon.net>
In-Reply-To: <CO6PR18MB44840100B18E768A90E3A5F3D8812@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260811112636.4106950-1-radu.nicolau@intel.com>
 <SAWPR11MB992100DA82CA3158F0D374C184A72@SAWPR11MB9921.namprd11.prod.outlook.com>
 <CO6PR18MB44840100B18E768A90E3A5F3D8812@CO6PR18MB4484.namprd18.prod.outlook.com>
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

24/09/2026 13:18, Akhil Goyal:
> > From: Nicolau, Radu <radu.nicolau@intel.com>
> > > Increase the minimum required IPsec MB library version to 2.0 As a
> > > consequence, clean up the aesni_mb PMD code.
> > >
> > > Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
> > 
> > Acked-by: Pablo de Lara <pablo.de.lara.guarch@intel.com>
> 
> Applied to dpdk-next-crypto

As usual with Intel IPsec MB, it triggers a compilation failure on Arm:

drivers/crypto/ipsec_mb/pmd_aesni_mb.c:24:32:
error: 'IMB_CIPHER_SM4_GCM' undeclared

I have to drop this commit while pulling next-crypto in main.

Please find a solution.
I'm still advocating to merge the Arm fork.


