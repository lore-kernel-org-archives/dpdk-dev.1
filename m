Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DC6CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 17:46:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8461C40697;
	Mon,  8 Jun 2026 19:46:13 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 47C424069F
 for <dev@dpdk.org>; Mon,  8 Jun 2026 19:46:12 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-304d0ac5e3cso8233349eec.0
 for <dev@dpdk.org>; Mon, 08 Jun 2026 10:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780940771;
 x=1781545571; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+CAJO01E4fFUkKnS4D4AygwfxetG1XBTuaREyCN+rsM=;
 b=hfKrGgNO7VEeK/l+njHfXZ3kjRy9zhE6ohe3+9NwTeSdnAeGeABJ6RwXDq5eozvCM0
 To9aK3bmr7IuKXl1kc7y2Gr2lzOjoJTXvj6OPG4ZXh9lT2MsZv+wNEqTPHavgrGYzsUW
 zp4uNIPwe0yXDK7SRrRoaR9LUmVXijpFEINzowa0jWl3kB7RaAb0TqeP/MpMOaoT2kcg
 ZgzIxBufQYAmMhReKiqnfe5PSYlbMf4J9GrCnZRVDGI5lcURA++bTdvoYdfCvm4NFiAG
 dHTE4tDn6WvExj9lK1oCDg28X66vYyx7LqDLOdXTz8iGUx+zTDri+3i3yOsDSKfypNDR
 DUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780940771; x=1781545571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+CAJO01E4fFUkKnS4D4AygwfxetG1XBTuaREyCN+rsM=;
 b=csTBqRQHHUACxqgiDQ6v9wn+goYxcKirenkijXbQSyVqiWEZp78b+n6+RdZNbl9Goa
 xAhY5ZvF7iFGezwHdwbhHGM1tQmtodAzGP47WVPbiD/UM/YYTJ67zzIv9K8igXyRjIR0
 ACQTwKP3uo5v+gbQ3h27rY85s5+kuYS1s0oVHgVSLMncNPECwkvtWGpk5G9iYTIsVWbp
 5a+zptuipm2pBROJfYxhdFmcR8YbnGM1hNQJiBblxp4OmT6wHzCpWShNrB2lHa9ORybu
 qkIk8eyEZC/BP3dCsQuuPXqfeAcUwQeugEPzZdvbvNlvgGL3TjzRfqMBECpWpKJoKeXg
 +1Yg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/EeSWqMmgDIvkzBTClBs5w/N53ND7YcfE2MUnmaOgqUq+EpqwJcrHFxfoQ1jc6CLGz/jk=@dpdk.org
X-Gm-Message-State: AOJu0YzuTmkR5QWKxlLfBoflnQPVJ7czfvx0XEcFBqXGxWdjF77Y2t0C
 LOR3eZ2FE/U8TljWkjmaAfKWBAcNAoP+zsI+jtaXUsgtoR3g19+U4obXD8Le3UEx/90=
X-Gm-Gg: Acq92OEG4uKs3FG0jiBav2O1lbc3khKATthKQ72nI4v84UskhFwUtHVKNm3vG0miPY4
 OwmqV+ebfThwU0MaxWBHeBs2Pq5T4K3xba702qW3q/S1fYwIn20KhIMKxqA6FFjOZbnodu3eCpH
 vOu1Zzra8D8OO+//HOkMIpobWuur4AnBGUulAl+BehTRluBoRuRSFbs3UPaYWKaZqPU6tcN9SaI
 n+w1Jdks0AT1PKdVi60iMaU+Pf0R+TLXSLk8GPFA1oYPkvDLSb+dC9hEYvzn82P06Fw9MM4Ubdv
 bSzUdnLoHHIJnKhHYLIzGcQNDEwkiZFxlp/cMSosVRXC5Uu4Ah+IC1RaA6Vo3ltE//X9gJxXnzz
 PTT2itDRI+sn4TV8OIXpKPPH3Kf4jfSAIYZ+7kLdIql9uXi6e6q0iUIwiRrlZFZdHqYw9+vlkPy
 HUXzzS+uk2oADskw6RDcDaBDdm6/NMK82eP9p/j107Wqd4Ge6duXIDnRrjllOdSOm4pHdQWEwe2
 EY=
X-Received: by 2002:a05:7300:72c9:b0:2ea:5057:a304 with SMTP id
 5a478bee46e88-3077aeed2fbmr8909451eec.2.1780940771328; 
 Mon, 08 Jun 2026 10:46:11 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df75ff6sm18586500eec.26.2026.06.08.10.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 10:46:11 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:16:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shreesh Adiga <16567adigashreesh@gmail.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>, Jasvinder Singh
 <jasvinder.singh@intel.com>, dev@dpdk.org
Subject: Re: [PATCH] net/crc: reduce usage of static arrays in net_crc_sse.c
Message-ID: <20260608101648.2919b542@phoenix.local>
In-Reply-To: <20251011113202.937991-1-16567adigashreesh@gmail.com>
References: <20251011113202.937991-1-16567adigashreesh@gmail.com>
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

On Sat, 11 Oct 2025 16:59:34 +0530
Shreesh Adiga <16567adigashreesh@gmail.com> wrote:

> Replace the clearing of lower 32 bits of XMM register with blend of
> zero register.
> Remove the clearing of upper 64 bits of tmp1 as it is redundant.
> tmp1 after clearing upper bits was being xor with tmp2 before the
> bits 96:65 from tmp2 were returned. The xor operation of bits 96:65
> remains unchanged due to tmp1 having bits 96:64 cleared to 0.
> After removing the xor operation, the clearing of upper 64 bits of tmp1
> becomes redundant and hence can be removed.
> Clang is able to optimize away the AND + memory operand with the
> above sequence, however GCC is still emitting the code for AND with
> memory operands which is being explicitly eliminated here.
> 
> Additionally replace the 48 byte crc_xmm_shift_tab with the contents of
> shf_table which is 32 bytes, achieving the same functionality.
> 

Applied to net-next
