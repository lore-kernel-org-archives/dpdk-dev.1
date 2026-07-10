Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C19EC43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 14:38:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 682E840150;
	Fri, 10 Jul 2026 16:38:52 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id BEAFB400D5;
 Fri, 10 Jul 2026 16:38:50 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id A7D661D000F9;
 Fri, 10 Jul 2026 10:38:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Fri, 10 Jul 2026 10:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783694329;
 x=1783780729; bh=MOLppHtvF+mTk8ubJNeGa9v01UKwoOarCICtALgSRew=; b=
 JFH9WffX6/msVSq26ckVK8WYg8pmcvExb+KCJHusJQuPEv9fZVh0Mh3X5uwnxO9U
 rtaJukLSEyoQzMr145/wJE5/sPE66wjUuidPndwJKnHIucnt/u6YqWT80ahoKiYF
 LOzMB4XT6Iedf+/4GdFOUDc94QVkD0DNJkPj68oFjolSoep44JUxHY01V5JEA0Ay
 Lf85vm86FbBGPUq+0BSeH9qliY79zWznZxyyxUeUI1f2oFYpKuNPHsGDsrtb98wQ
 GpFqbzmHSZc1YukpF2Oubk6KgQ06L291wQzY5P2hrJCm40RhVNMBJd9EgizZMqzq
 XOsiXxQUEtl0zXMbFX5qxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783694329; x=
 1783780729; bh=MOLppHtvF+mTk8ubJNeGa9v01UKwoOarCICtALgSRew=; b=j
 F56ruZHbBxbVOrRa7Xjl/JumJe0P3PtZHe/9bOW8NEJzRcvG1y06jUtAI83hYVH7
 XrLqT5ug4OQswZ07713lC81db8uFGjWnQUik0WSmbk74vkUt7LgbAkYkxjSeY8nT
 0YkLFDgEbDkwVWGmBGdHpJ/rEoqJFATkofbsoQgY1VOZUi9TVzWTPh8E7deuiPEt
 UKXMxsI1wPLdhka+UeODRWZ6SdMN0n1puLXYeAkKEIynQlo2gWAERgfAWc7fT/lF
 JaCFy/OeImOZu3zmvmQkzqWQ7yP445qUhykJFWnOOrCa2Wkm14ZjyA1BM+PpxfpT
 yX8D4Ver5s4qEBBSExuqw==
X-ME-Sender: <xms:-QNRapOhcARzYtmKFZxwf7byjlOs0Y8HX7O76X2OaxsDVcqpZC-ELw>
 <xme:-QNRanYrOdFhGw_eKDp8nifilz4ExFODVig0eeZ2VeAbngSBdqzb4bpiHEKtigv7Y
 6slsRtrfSmEAMlK2v4RjZ2MkcBfJetkNTnk5bpNZn2-CpE48iz7HQ>
X-ME-Received: <xmr:-QNRaryYFl8at0bfhMFadEbRwOT0lLl182CAiyaOJgPsGksO2P1kXdxpRHrO8qyNQdqqFmjc8hWjUmrVAzrQUQ5yOQ>
X-ME-Proxy-Cause: dmFkZTEkR/mTZOGmknEI4qYacjnDqEk21P088Oupt9Hn5bwY8aCkm/W4OC1w5pzeNfG2Fx
 j3Yn5451rCH9fsMgQUoFT2ALym4gGKzGfssrE8u+fm3QaC9sL75xjt62uzzryNk4cggFVR
 LpIV6mntwn0h/PgcH1ksTc8D5LAzSk62E1UDgjgiHChDkQo+RX5JOEtXkJOCxqU4WvlPEX
 qXuSjvcrUuExyLshXbbf1NtCPdlsCjNi3PuGPkALc+fnoPDf9asXJU+eHbgdlhv53+uEyJ
 XgFIsvkSKrBvUtvWa/W+81CMnvv8RWzGbRBVMC5kxYGFGBSAc7YU2jEFQbFq+GDL+asDsQ
 NeSP9vTquI/5qfhZtr8TDeed/T1jJ3+KLwXOQx4dtMNXgNvUG3l58YdYsBPpEx4mXzo0XK
 7+fZWf+smvVZG3H3mJ96+H8lllU3gjA5cBcaLuxwCuqpi/iMLuYLk3IgJSZ/t8F9nFockO
 1ZA5puJ6iRxbioTLRjol6/B+JmS3NathGejZBmsV4zfaTHM5MM0Qaas3jMPDDzhI49PFWR
 QbluXUfKZdxVwWJxq8ESlUVL7nnwdUZaPBoKZYPlZX7UAGgcgV7bPS22Aeg/y1lT14Yq7X
 uFkd0zCL5uL4UAJBcJE3KG6/PMbrELeOEEoJu7cP3wtwTJLOatTHQjddTKYw
X-ME-Proxy: <xmx:-QNRaqLWVLr_VRiRo8VD3PZe0SoVqDcy8hrwCPF2XyIaYXk4XOmdRw>
 <xmx:-QNRatqBX4uGHgW0wWThheKx71k_VSLxWHYaRk8qg-3y_hDqzfL3zg>
 <xmx:-QNRahJQ7Wze0nhOLad6DBO2OcaAUyY4zoEsq1mvUkn3wxAQW0e95Q>
 <xmx:-QNRaqQAqTg65DWgtMMs9_7XFWl71idLd38gHm9abeQTNi0KKFg_3A>
 <xmx:-QNRar-ObjJ2QzrsMggySAYAT-JeTN0CaN-DCoxgY5-DpCdbQQq28KrQ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 10:38:48 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Alexey Simakov <bigalex934@gmail.com>
Cc: Chaoyong He <chaoyong.he@corigine.com>,
 Alejandro Lucero <alejandro.lucero@netronome.com>, dev@dpdk.org,
 stable@dpdk.org
Subject: Re: [PATCH] net/nfp: fix UB in BAR size shift operations
Date: Fri, 10 Jul 2026 16:38:46 +0200
Message-ID: <i8TrHM9iTYmeFC_7-DKzYQ@monjalon.net>
In-Reply-To: <20260707140112.140833-1-bigalex934@gmail.com>
References: <20260707140112.140833-1-bigalex934@gmail.com>
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

07/07/2026 16:01, Alexey Simakov:
> The literal '1' is a signed 32-bit int. Shifting it by bar->bitsize
> is undefined behavior when bitsize >= 31, and sign-extends when
> bitsize == 31 (producing a wrong upper-bound check). BAR aperture
> sizes from hardware can exceed this range.
> 
> Fix by using RTE_BIT64() which produces a 64-bit unsigned value,
> matching the type of the operands (uint64_t base, uint64_t offset).
> 
> Fixes: c7e9729da6b5 ("net/nfp: support CPP")
> Fixes: 1fbe51cd9c3a ("net/nfp: extend usage of BAR from 8 to 24")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Alexey Simakov <bigalex934@gmail.com>

Applied, thanks.


