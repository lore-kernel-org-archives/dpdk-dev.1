Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120D2FF885A
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 13:24:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48B5B4027F;
	Tue,  5 May 2026 15:24:38 +0200 (CEST)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com
 [209.85.161.50]) by mails.dpdk.org (Postfix) with ESMTP id A51864026C
 for <dev@dpdk.org>; Tue,  5 May 2026 15:24:36 +0200 (CEST)
Received: by mail-oo1-f50.google.com with SMTP id
 006d021491bc7-679f6ee3fb0so2045686eaf.2
 for <dev@dpdk.org>; Tue, 05 May 2026 06:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777987476;
 x=1778592276; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yvbCKS4IzmrQCxQg9d28QrD3Wu+bBlzIKIYw9kbvERs=;
 b=YfWZUrC7cEb6oeagsoq77NOPPhEgCTIXkJ3aZ8D7oYDKEXvW6LK++u1/mwPEYH9zXc
 cd/NkT88lY5t1bxbRIoksJevhr6PCZvwdsG3FpwPQaghcyCV0WlNKVRi5efW4BAJBjLz
 OJVjR0f73TkMP97bFRz7xQSt+mLEr2AZcPBFZmXfnMcVJceS2RGDOqNVuRXZ+nYYhF5h
 cL8umgG5skTCM5dN7k9BtRbWdC/MmVzsUlX+ehUVRSQKo8GK78VgU/ZOOt3ySJQZG+H/
 DBsVVxymCKR0bWU/yib/j9AYt3g/kwUorpzIhONSmwIVftOBhcm9UISqnyVsK7A3MHXp
 BpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777987476; x=1778592276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yvbCKS4IzmrQCxQg9d28QrD3Wu+bBlzIKIYw9kbvERs=;
 b=lLGXdyhakAU3jkxdzREXC3l9ekCJfn3NGB7Sn5Sj7eDoiJjQDXz4an348wnB/fnqAv
 PTKKrqE7UF3JyzhVO2o/MgBFcwk3SJKd9EzbY48g08YBfmPYTlZWzI3bbPSeqk/CNVJn
 ymHWeSvr1XrqHfTzC1uJItelO+M5vDLOpN+N8giLle1gmM6wZ+lmdvhEXpMLM9CjPlyN
 tGPY1bTrC9hu10mcayh108Ix0JAx+xHKh3BA7e73mlN4b3KPqBOFzJaGtqwjw8wav7OP
 7hpFrDxtfxfDKiNg2rkAy9B+0qZJtS+9M91ysWkyUn9vlGWK+pJ37UKFdLFml3SKs+r/
 MUuw==
X-Gm-Message-State: AOJu0YyWvQcwvmrT+g8KTrTr03x1l/skml4JWLLECJncaywIjHdfXDeN
 lWjvuAlTTqgE54K/DZhfYXg4lrXM/i4DdmOwJKoobXhp+TPsEMdK0p9gp+5a1EjBej8=
X-Gm-Gg: AeBDievZ0XOTm67FHuxffRlK9ik8sinEsjAVAGCbfiIwGlG8TMr4Abco9rJO4g4ygZw
 rGXGf2zWfz0PMpdg2GH4FZg84uiNror6gv2VQIiCVfL2OiDXnpiB/TmzUG9NSIlnnOM/pIaZKo6
 eccse8gbjHW1XWQIeK0a+/h5Qx7KDtiPfpeCmWSDBZ31JjTEM++OoBg7XOaFjOV0dGfg/Ao9Bfi
 WHUTDV8oNAbJxoDimlBR5Dtct5yuIYvJaCIer+aezQj8Uqg1/hGmA8Rx2K55hZq+05WaQkKRVlH
 kLLVU+LgfhbmDy/2/gae0Tit7GuGj2xmYZV24BijmccZAVmGWosJoh8dYbrndiCBL32vbkpVsvm
 Fz3/eoFaZH2Q51b/OyB2TPMPQnbzrqMAOrnOx9yoQ90rhJOsLAQj/QdGAInCeaVxPkKlvSy8BOn
 PeeOXfHI3ijbuNGKFwr3q4U4gkOGhc/OCUxM0oLquvu9n2AA==
X-Received: by 2002:a05:6820:a01:b0:696:2b5a:b516 with SMTP id
 006d021491bc7-6998d460d28mr1291680eaf.41.1777987475817; 
 Tue, 05 May 2026 06:24:35 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69689266bacsm8393804eaf.0.2026.05.05.06.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 06:24:35 -0700 (PDT)
Date: Tue, 5 May 2026 06:24:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] spinlock: remove volatile qualifier
Message-ID: <20260505062432.18d9ae90@phoenix.local>
In-Reply-To: <3066926.2VHbPRQshP@thomas>
References: <20260504083714.2904729-1-thomas@monjalon.net>
 <20260504100239.07d48122@phoenix.local> <3066926.2VHbPRQshP@thomas>
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

On Tue, 05 May 2026 09:01:43 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> > PS: I wonder if we really need to keep the transactional memory versions of stuff.  
> 
> I don't know, it's part of the API and has no maintenance cost.


It is not tested, only worked on x86 and most of the CPU's and tooling
dropped support for transactional memory years ago. It was a failed idea.
