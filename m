Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF0BCA5FCE
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 18:32:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EC8A40144;
	Thu,  1 Oct 2026 20:32:29 +0200 (CEST)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43]) by mails.dpdk.org (Postfix) with ESMTP id 8ED17400D5
 for <dev@dpdk.org>; Thu,  1 Oct 2026 20:32:27 +0200 (CEST)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-8633a38df87so2994725b3a.2
 for <dev@dpdk.org>; Thu, 01 Oct 2026 11:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790879546;
 x=1791484346; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qeVJ3C3dxkMnu4B5lMTlXpE8BYvnyUpVJrKTgO9TdJk=;
 b=jMa0v7ZwsPkRsGB58srI/YzzgGHaPERS5VdqFC7Hx/EtJ9gCQhdQqIA6A1lbnRW3B6
 4ATls3fbFfUgN/PrWVzhQcvaDE9pbSdFoFVYH/1ttKekCRR4LabDnN2RaK9c+I9/VkY2
 BLl/yXUZAclT58Gbqv14rT7roQv2oOhCe46o1RqaVut5U0sj8BBbEut8x2OdPeZyhG8F
 PBk4AjY/A5/8SI61vtsEpKgXc1G9xJ9/SZ1zSzpO/tXyhAFcmeW74PryxLMtXPTSJHFc
 KyCDJAS8N27PxMRMQvsDHbV9MLXALNZyTjQE8COX6eYDaFFt/GHu0j7+oWgvAvBpg+IE
 UE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790879546; x=1791484346;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qeVJ3C3dxkMnu4B5lMTlXpE8BYvnyUpVJrKTgO9TdJk=;
 b=vbjkNgxEYC099Zt61lze2UwRbRnHDLUY4OpVRugbsPLVhCNkQJvXMq4OXBiLqQILzu
 +hfCV/f0MGQARK5hBsyZ0Xt8Ed67Xj3XBW3mOUUR7fnAICi5bVedBll7xkOGBuZNecxu
 60IuBzemmjnoBSYHvRwdblp152DMRuOx3L7z32eQTX6xSe2NZIfQMwzWZviwpQdGf6ux
 lniZ2F5a+uWaafRyijuqdwiaGvDnWGDIxId5NQ2V5LFqBCdZcXm60uJb/USTQIm7zdZA
 zidJufVSmveEBuhSgcz66FT5tIMKCdNbeh/3jooaxoyaXbzX3yvMWamzROfDOvHKQjij
 KknA==
X-Gm-Message-State: AFq9FYIwY/WLAU6mGCYcvg9/rIj1f+0558ajH5kztP8xVwK6WMItSGQ0
 shto8ubfE7kmlCJEtWhhs0A1EPmImL+hoYosE2sq31WqrtCOAQc72nyg7zh0sFN9WiQ=
X-Gm-Gg: AYBFou1yNFL5lFUa0E3/HKf7+YdBRw7qUD4aupNz2iStFnpAx+XkZFeadoJmaSBDmaX
 pNko9/Bcwb/6tV5VYckmqqVksoC72lxaOvyL5MM5DJplTThkbhnmySxVnT2LURDHNdDZRUSabnq
 LkO0qiTvDS42qcV2qWUyFWVHMj0X9jUzQyL+PTzC2IKMxq/wD6uu2RrsZ5iI7Mo0uJGxD/9A+E4
 +e0+lCPbog90wda7P1jwUAvDlO9eMvOmsyvYFv4Q2JFmREKzwZFZqfVqKaQCYKnYvGGxSTOKWiv
 iNqoyPDKGFXb08FhvAPE1bdb0rHsOSjTtR/tJA4Nw+k8Dnw6vA99bxJcZtD+mmEkVJaM7jffU3Z
 FYR2K9XabqgYspERwKDmi+syl2TFl/raWT1PZo2B37m53Lspnmrb9jnyhZFx1DuJgywhZwXfleF
 BFUUzQiErE5WV589a/mwkCq1KDg1tnzZ0gajOkRqwlQvdA8yQCvR13zOdSAZxF66Is5dCI2V9KC
 F7vWwyERMv2dqe2EjiuGhFr+rSg+JRTYgm1pB70
X-Received: by 2002:a05:6a00:14cf:b0:87a:3144:8c4c with SMTP id
 d2e1a72fcca58-88af6f13352mr369415b3a.59.1790879545957; 
 Thu, 01 Oct 2026 11:32:25 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-88b0b8f6ecdsm67228b3a.14.2026.10.01.11.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 11:32:25 -0700 (PDT)
Date: Thu, 1 Oct 2026 11:32:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH] ethdev: replace rte_memcpy with assignment
Message-ID: <20261001113224.6de75054@phoenix.local>
In-Reply-To: <e42e8ade-b0e0-438f-b5a0-eb3f7e95397b@oktetlabs.ru>
References: <20260929155701.877309-1-stephen@networkplumber.org>
 <e42e8ade-b0e0-438f-b5a0-eb3f7e95397b@oktetlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 1 Oct 2026 11:14:13 +0300
Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru> wrote:

> On 9/29/26 6:57 PM, Stephen Hemminger wrote:
> > Can use structure assignment instead of rte_memcpy here.  
> 
> It would be useful to mention in the description or summary why
> it is better.
> 
> Right now the description say what is done, but it is obvious
> from the code change.


I thought it was obvious, it is mentioned in AGENTS.md and there
is a coccinelle script that finds places like this.
