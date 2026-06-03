Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B95CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 19:52:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEE7E402BA;
	Wed,  3 Jun 2026 21:52:00 +0200 (CEST)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id EFA18402B6
 for <dev@dpdk.org>; Wed,  3 Jun 2026 21:51:59 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 206797A0088;
 Wed,  3 Jun 2026 15:51:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 03 Jun 2026 15:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780516317;
 x=1780602717; bh=zGT2FXuwfGUd46xWpt2yMoGXyCT9K5fQ0QWVvPkUCOQ=; b=
 QEVqkex2LriTIHvbRSvIq9yQX5klpvqAiSjuHu/NdopU4IGWgZawuSt7bMHvrk9w
 e93Cf1MCYeHUSodCVHpzAqZK7XktEJEKEYXM5BR4kqRyVsc20n28vUrwGlkCHJbU
 t8atqFlHUp1Cy2S6rTfknKrNVYtoZUBJ8Ww7OoJS0f5gE41uMPU2R8U3cXyTiM2f
 YPi8krSj1gdWajwssimM25zLIyF3sZ9yuXRq4FQITbGHwpNAHiqew67qg8GiCFjp
 oGS+KChC9rpTd+SVdgFW0doR+d5nyWJ2oiKT91uLqxr6Kx9Cldf8gZgFP0MspTmE
 Xd57Rp5rjtAIUBRZz0rXAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780516317; x=
 1780602717; bh=zGT2FXuwfGUd46xWpt2yMoGXyCT9K5fQ0QWVvPkUCOQ=; b=W
 qDfTG99umOuWSEMGZrDNsuBhF3sKgm8CS7P+R8hHKUNGqmQ6TaL8CAwOPbu/t+Jg
 pSeAdRmlHavIinSrhBA2lJOlo9K7sqMoguTajOFvYxvWCJ4z5LctbJVs3/rbq4O2
 IehkS3DjjJ289tk7FiB0dgdE/C0FzYIYP5Uxpom8R3lnwEu4tnyD/X95Jt/oQJdW
 h5heSA8gtP1+UjMmqgfHykBVOhzet/Hyi/H1XHXqjF5qBC9pXozLDadwUsR98dBh
 mbc7AhlY8/zB3lPyV9wLoMEsyhpCrk/gLWubB1NorOoqQhzdK0urnph/6ctTezAA
 XwkPIlXtIIv5g7FjxKSxA==
X-ME-Sender: <xms:3YUgaoI81XouE5vs_vbAlJ1vjIyPCiIe6gylhVAb1ANFCnqO7pPLdg>
 <xme:3YUgataY_nNyPYOtgkGa89ud0GD-ZUfniNypLWwgBI77Grh2GNVM5q2AnEXlfeSCr
 k4XvEu2ks2rx0EIgecPIoxpfvsnzWz29MV7KM9poWd8YyIjAOgvng>
X-ME-Received: <xmr:3YUgaqb2knJ0usTr8vnpCyXXb6v_bPkZmNICwXhoT-mK0UAB1_LVaKY_EP05MgIpnPTWGLLeTingy641i9iAIiibhw>
X-ME-Proxy-Cause: dmFkZTG2e5ONgJL/B1HSKdVmEJRUhkQz9nJSC2gUgdn8r1v+E6edO5ORBCbKNxYLHmbf89
 PisQNRG6v5Skhz3dQnbjaBwJarurhemyJ3Sm9blKaKSFlwpO6+FPyJ1OPDmgk5MkzFD/i4
 vwHrlriw5VaM3a9bIzQXvtM4Zwgjw00vrSRe4nDq/lQVsLqNk/gTiwolzrQoCTKFvHaugt
 wv6t9Y7rY1qSBHpyFz5fhycg7gTfSRZdtawMP0auiepiGXnMxvRlARMDy/Z8W6EIJmiCH1
 sYkmQBcjJAZJEaYUTfMesJd888lv43XRZMd6ztISK5I80vRmSpt9HXA2m23G8uiJ1wbcZ9
 uCdu2OimlgDyLYLo2R3+veX4Rvy764xaAm5BQIU2iTPdev8Ys5PIz2Ej4yi0bLJCuyvdwn
 FNkjma+QneitqlNv4bKUPbuUn7ALex26SpFrrDBiFazdWD0OA5wBCjLdmLsBxuZon+FBuc
 eC2cpANvhcWeHVcciqCFhPhMHdlM6QfMj9WwsdgWgzKaGjN0Jpnx1duCtWgFKjWSnhrh9X
 joVBZrqBXBi4ijSE2KZhTKzinb8m9EXRiC2SD/5BEMnvaGvzeuzam48u1eQ5XD/OHg9z0J
 3YOHJrHjEH2monJ/rqR8wCTFnACMXeTaxtfyAa5ujfj0poxW+6tM3KeT5rBg
X-ME-Proxy: <xmx:3YUgatkefVvl0Y5Vdkt-8BbYh-Q5BTby_Zk8TksGm35O6WFJUshtPg>
 <xmx:3YUgamxh4yNKEUXqjd_bZEKv2jEt6FyY-m2IwfGe9KOMtk3Wd5HxjA>
 <xmx:3YUgarMArvLskc-MI9mQsG98DmMfyrdDdCfjewo7S3ZjL9I2UqyFqg>
 <xmx:3YUgaqQJUyW0VmQ2viSNPl7NsBZQX-3WbDLk5n4S6wE4o4FPiH8oDA>
 <xmx:3YUgasdCvetkqiRX3UEDAL7r0ZcPPgbA0xZFlpjr-0MHKg2QCGsmT1cR>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 15:51:57 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/4] remove useless null checks before free
Date: Wed, 03 Jun 2026 21:51:55 +0200
Message-ID: <lZgB-I7zSxecu9v0_5A3sA@monjalon.net>
In-Reply-To: <20260401164108.201404-1-stephen@networkplumber.org>
References: <20260401164108.201404-1-stephen@networkplumber.org>
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

01/04/2026 18:40, Stephen Hemminger:
> Some small cleanups found by coccinelle null free script
> 
> Stephen Hemminger (4):
>   net/ice: remove unnecessary null check
>   net/bnxt: remove unnecessary null check
>   net/zxdh: remove unnecessary null check
>   app/test_compress: remove unnecessary null check

zxdh was merged in next-net

The rest is applied, thanks.



