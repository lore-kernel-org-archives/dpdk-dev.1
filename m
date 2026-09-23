Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E86CC98302
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 16:48:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5776B42E81;
	Wed, 23 Sep 2026 18:48:38 +0200 (CEST)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id 7C5F44027C;
 Wed, 23 Sep 2026 18:48:37 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id A1EAE7A0132;
 Wed, 23 Sep 2026 12:48:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 23 Sep 2026 12:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1790182116;
 x=1790268516; bh=u3gHa4NKuEgKp23OMcbCwd9tQ8GxDfAqZ9VvdfPBsfM=; b=
 ZC3K9YO4N9/1oBVpEbDpC3psGkUsisA2TmeUmG7USjOgtR8mYOdnR9qGgOmpOQsc
 ADhz68MsYFkZEi4v8felFjy+KgE2yMl/FVmuYIscqeinQRciPx5UJPCvbPZFpCOw
 usVm/TKC2qgoa1qVBSKGwO0BOh/aVoGKVn33N7iIjUZeOkCxK2UrekCFWAtBj3mi
 U2VVkpIyvVydofvJui93NbYf+r4eUmqp4hkexkPTfBd6hwM9PUXFEt1PUkQmOmY/
 xYwurfVNoQRHXQaRXwXJoeDjrjYyp6b2uXl3hyXoiB1EW8DWPfHsLNtFztMKcy9x
 eulcW8HJaMdRcx1kjaRWYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790182116; x=
 1790268516; bh=u3gHa4NKuEgKp23OMcbCwd9tQ8GxDfAqZ9VvdfPBsfM=; b=h
 9FIIaK1kUs7168ySvUQ3yOIi2EWzfR6AK5bX2tOyP/h7/hXsEoBjMjcjlimSF4v4
 QJENy/1es8+r6JIgHpba0vpn2KUxWHGuZcSR/xINzEkt2ka/uzIU3FY5TS6R8Z09
 RVJk07M9h4FCnDuV1jcxhFTKm83ucT2MTl2YzmP0F225w6cqa8UQ5m7FahbOlLZ1
 sqSTDqMERkEvE1HETggV8DPuqUoTCHPIO54vlRE3XJNgqTMVdLP2JMMxOZVoABul
 bJcSdbC/zPTNKwR2BaMCWMXTLF75CYRdbf35v+lm1O88S3It7E3vfAUUgd7HtWbX
 o/nDUN8PLJ8kd7fLMiHTA==
X-ME-Sender: <xms:5AK0aikzlEdNAMB_9E2JgIyUVShgKCr1IsNj_HinNUyxaM1MlmnkCQ>
 <xme:5AK0alTscqarWVs0Wz3nD3FWS3FQWzypi5OH8vs1hUgpiRpof1Qfjp2uEZchQ9TrN
 FzrjBtmbIiaqpka_vCc7XkngzarImw90PdM7CF5pnFt73q-xVJ1vpw>
X-ME-Received: <xmr:5AK0akIrnVyiw8hZyRp9p-9Eh3-a84JD6d6VCBqf87YEPO5pn_sIdIkLAKACoYjFA-pZgZbtg7wz2d2L3Jg7avs>
X-ME-Proxy-Cause: dmFkZTEtIFm2FOjF5FB6QAECFx9k3e9i8Fwyj844pgZsKvJGqnhjj4XbiC1BqGHyFHjYap
 3t8o5BTMSv32iSz7H9yR75QzqpFBaQVpmoW0CiRoHIOadiRaMDmQOweDSByh2wHp5SbTQY
 Uiy3mFE4TG/Ml1GFTJdlKXMZ5ZGAElfVZ3yEDjwvMcUMSYjk0hGFerixb/IX6kMx+e6mIs
 xev958xXaxw0ZcmaLPCNOhy0jPd1RDphImhBvsXcqQY74keXFpuhMIaAZlynUMPUQSNcTn
 C5U2hiusg661bOhtV8uHB1SEUctzOtvR0bzEc0/FMZb1DdE1PjYG0KEnSooqdHsZymfDJB
 fEgWQDBqimppn5o7wtSluH0yChmcB1aehGZd1XF1J5L1LZktKe5WLdtAEM/nYL1opLZzgW
 jokGSyx28DndYwHeHayeBZuBPhQKTnMOQNboC7GY1pPTlcARwMJjQBVGgit3ir/MeZZfaz
 ycbYiP+mO2grnoapHdsjNa/iEH65VnzsZw6ZvUCLuPMFZonjbdTV7L4+httMO/hA35r2MT
 Di23L8YMHye9tdz2zKKeVNXGUYMgyu0GBz8n14ymWt5SQEu2rhVyzfhBT2g4hBrKAFYaD8
 jv6bxa66Xwmcq0yAXo6vkp4ry7Mlu/VcPHSDiMVudCchorNHZKisSuj32VeQ
X-ME-Proxy: <xmx:5AK0arCdzdu2x0jg8vccHVwSlfZXuRbDTAUW7L7eRlubCGqqBM_31Q>
 <xmx:5AK0atDWivNudHi50Dz9trVl_sM3rMl7sX84xJe6fIDxgQ_ldZ05rw>
 <xmx:5AK0atCAfVzMji21f0zEaW8zfkAtnvT4cS_n8shOdFGmWrT8iv5d3Q>
 <xmx:5AK0aop1AHgJ5NQWdVeowMSPRcxhfxuMuBkWiyJVk9tZiQZg6052UA>
 <xmx:5AK0ao3Vr_60ofI2u1PlmuBso2jw7HiEI9EieAz_bVTRCWAoE_egiaTy>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 12:48:35 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Yonghao Li <cruselee1@live.cn>
Cc: dev@dpdk.org, konstantin.ananyev@huawei.com, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] eal/x86: fix LZCNT CPU feature bit
Date: Wed, 23 Sep 2026 18:48:33 +0200
Message-ID: <vdxtIy_6RCmB6PVFi6O4VA@monjalon.net>
In-Reply-To: <apU1JV-ays2oJDgZ@bricha3-mobl1.ger.corp.intel.com>
References: <OSZPR01MB8612B5D71DC37D3A5F2D428DE0AC2@OSZPR01MB8612.jpnprd01.prod.outlook.com>
 <apU1JV-ays2oJDgZ@bricha3-mobl1.ger.corp.intel.com>
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

31/08/2026 10:02, Bruce Richardson:
> On Fri, Aug 28, 2026 at 09:32:52PM +0100, Yonghao Li wrote:
> > --- a/lib/eal/x86/rte_cpuflags.c
> > +++ b/lib/eal/x86/rte_cpuflags.c
> > @@ -137,7 +137,7 @@ struct feature_entry rte_cpu_feature_table[] = {
> >  	FEAT_DEF(AVX512VP2INTERSECT, 0x00000007, 0, RTE_REG_EDX,  8)
> >  
> >  	FEAT_DEF(LAHF_SAHF, 0x80000001, 0, RTE_REG_ECX,  0)
> > -	FEAT_DEF(LZCNT, 0x80000001, 0, RTE_REG_ECX,  4)
> > +	FEAT_DEF(LZCNT, 0x80000001, 0, RTE_REG_ECX,  5)
> >  	FEAT_DEF(MONITORX, 0x80000001, 0, RTE_REG_ECX,  29)
> >  
> 
> Confirmed by checking Table 21-90 in the Intel SDM Vol 1 docs. Thanks for
> catching this.
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



