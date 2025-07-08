Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA5CC8303C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 21:56:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A67A40649;
	Tue,  8 Jul 2025 23:56:49 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id 8D38640292
 for <dev@dpdk.org>; Tue,  8 Jul 2025 23:56:47 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-7d9eac11358so156623885a.3
 for <dev@dpdk.org>; Tue, 08 Jul 2025 14:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752011807;
 x=1752616607; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yM9oTmQbAgF1FTeCiIN0tu4ZU/gLvWWM1ZbMPhw66WA=;
 b=QEeXMlgkJkrZo5EkZvrnFMVlkYzFS+oFCZUEYEuR0uRwaHaZ7WiGtip0PwGefNap6t
 JgWTiXtaewFCnVU/do4OEcPYBksMjy29vNcn6pH+cAtsOsEHsS6uCHHCid49HwHsuNV5
 5R4qbuatx93MuiYsrrqEkChgAgCjQKEsMpDlcRJsRmMmvrMFUokHLC4wwQDWTghGNaWe
 +un+X8HTBGxMIUR9aFzXZy36QdUfRlIM9WkJE7+fQW0H19FuePQAYgGKPvzwuW7ZZFb1
 +ST+RWqatNUR5sWHMhRm1gjU8E7I8L7R+IiGfPe2s7HSbdf/fAsK0T0vpa+emBUKsMFX
 TQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752011807; x=1752616607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yM9oTmQbAgF1FTeCiIN0tu4ZU/gLvWWM1ZbMPhw66WA=;
 b=kzW1KXC95EvTwhPWbbEs72leomK+pjSKzxED5NuEEHhEH9qOk82H73lZrUWLQaSsTG
 rUTPEUBiZ1lUcG79UiaChQTftCrF1yuQHjfE8Xtet7i64JcOMOZPARZ2I3oFGXnQNc3f
 H+sXksyy7VW/9y1+4nHNTjwTv7z3HJIHzKwolQvaF+1wP++hj+9tJGQt2Ta78/4uVnvz
 kimVstvqcg2elZpYmpdaRNHdaMI9JKNkonptaHxfy2VWvrhnt5Enwj2HwoMCDMfhLCz0
 w7bbK26wVjSGUs+fmoPMOoWlh3iUc0lHA2BudfjpGXO/GRV33YqEXREr3uqDZ4LLGOJY
 I/rw==
X-Gm-Message-State: AOJu0YxXrthVGxXVoFp/AvfwYN8Tj6+45QGsd41gTTmMyt3t8gjeTwV3
 J6Bdwow+lGCEqkzKPzrNddRxgLJTYkONbNNM9990EBJvmxFTWYPIjg4rEMR/tzC0G7k=
X-Gm-Gg: ASbGncucu5y4k0p8zBlemwPnfavF8fACwypvdC71UGTq4W+DwgJyPJ/SHPZ952BEdi6
 WyhJksiilf7Nl2NjO79QCPh1BghG6RTlrGXxgsQk6fzMbIDEi6dEVezR7F0Plbg3fbty80YV8hE
 hubqcaA4Fdumjd+NV03AGmheX70855QoYD5QnKjAWBniUUoDKkpKSjDqX9CUwR2+O6Tt0tZGTzT
 eKEx8Q6c+IFQc9IFPqWq7jUHR+Kii0FYiYEGrMZHLHLdl/ZErJdV3aMY8GwJYCJSRAyisH6wTjt
 aZJMFtSwDcKHWZziClOCZ/rNcgyncVEEkzrjTaspDIpQCcG7w1nFBFj+vGlWpoSGXD7hGOqFPxN
 xTg0myg9Cgbw2yzKiuo33iltH1/96ea8rUrzqkAw=
X-Google-Smtp-Source: AGHT+IF3EnJmKJrInMxKNSRGey2Py3NayMH1gFF2BXnBDjTNprfcREiuUMWtkbd+PHuZgYcSV/kqng==
X-Received: by 2002:a05:620a:c55:b0:7d5:dc35:281 with SMTP id
 af79cd13be357-7db7d78da9amr33568985a.38.1752011806672; 
 Tue, 08 Jul 2025 14:56:46 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d5dbdbbbb0sm843409285a.40.2025.07.08.14.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 14:56:46 -0700 (PDT)
Date: Tue, 8 Jul 2025 14:56:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Schneide <schneide@qti.qualcomm.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Reshma Pattan
 <reshma.pattan@intel.com>, Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v3] pcapng: allow any protocol link type for the
 interface block
Message-ID: <20250708145643.738b62e2@hermes.local>
In-Reply-To: <20250708210245.3967578-1-schneide@qti.qualcomm.com>
References: <20250609211937.345620-1-schneide@qti.qualcomm.com>
 <20250708210245.3967578-1-schneide@qti.qualcomm.com>
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

On Tue,  8 Jul 2025 15:02:45 -0600
Schneide <schneide@qti.qualcomm.com> wrote:

> From: Dylan Schneider <schneide@qti.qualcomm.com>
> 
> Allow the user to specify protocol link type when creating pcapng files.
> This change is needed to specify the protocol type in the pcapng file,
> DLT_EN10MB specifies ethernet packets only. This will allow dissectors
> for other protocols to be used on files generated by pcapng.
> 
> Includes a breaking change to rte_pcapng_add_interface to add link_type
> parameter. Existing calls to the function have been updated to pass
> DLT_EN10MB for the link type argument.
> 
> Fixes: d1da6d0d04c7 ("pcapng: require per-interface information")
> Signed-off-by: Dylan Schneider <schneide@qti.qualcomm.com>
> Cc: stephen@networkplumber.org
> ---
>  .mailmap                               |  1 +
>  app/dumpcap/main.c                     |  4 +--
>  app/test/test_pcapng.c                 |  8 +++---
>  doc/guides/rel_notes/release_25_07.rst |  4 +++

Sorry too late for inclusion 25.07 release which is in last serious bugs only stage.
