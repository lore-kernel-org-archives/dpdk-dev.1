Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86CDC7EE30
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:25:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E709402D2;
	Sun, 29 Jun 2025 19:25:41 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id 7934F40288
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:25:39 +0200 (CEST)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-4a43d2d5569so19845621cf.0
 for <dev@dpdk.org>; Sun, 29 Jun 2025 10:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751217939;
 x=1751822739; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y2WqM2r+U4Vbiqcq9261mp1d1gxlDKX3P4vweBkBYYk=;
 b=psbbkBihYy9tctNJCwHcQ/ygxqH6R7OMuc7QJX4D1GPhexiJdkAYwabUDvRfFW47GC
 bWbmMstJHsygOErv7ji+xTUQ01pUWoR7MHTkBDoVAJy9jegG10hNS9yIEpqZzEFHG0PK
 vAco65WdAIIm5Vba8Xgp67TeF7v1uZ/lIsdQUjPsPsP5Y7ZCmrh/01tQNAPscHxok2iV
 vO5OjGUAdlQJ1BMNBukN/IEEPfuzni2kmn+7hpYMdDK+0np31HjXkFJFdSB7ESyr4KAo
 iBYWx3FQv4S6Xcv5mmDIRhnquvIYtgiR2F1dmbi6gJ2zll7K6VDpDDbVhb9jZDSKp70Z
 OHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751217939; x=1751822739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y2WqM2r+U4Vbiqcq9261mp1d1gxlDKX3P4vweBkBYYk=;
 b=UoPARBKDP+mJ46cm33HCLnyINKFfm2+1dQu2ozjzQQjWskbBwJUkt7U4aRj6iNfySC
 y8xdpj6Y1px3X5GBy9KADCCXpjB1o3HsOH6vNRMxwO78xBoXAR/c4yUESrNX6GRmZ51N
 p8jLDgxSuIq9+NS+27kTbsz+hoJUJDoNzcIarm82cPGECwl/6SD3W1MB+IlbSkPhQ2VV
 Bg/4W/mnFHn2vNNghUwimH9LjMa8yJqKom436y81Bv2xRr6W1Xco3eeTh1epCdA0r+s4
 pIuglnUv2iCZxif+2vDtgDUmO3I+HEqyfnL/L/Vr9AX2o3VYThzAJpJ9owtbl3m+Qqan
 xm5g==
X-Gm-Message-State: AOJu0YxlrdUnpONX+soEW26lTgUyT3cXocFK529VFeOpunUpMkz7d7yB
 sJVfvPrjM5NgVXsUtQoe0kcg6LBY3NZINLu0CuICG8LUEO5ICQOjxzbfVPeopWrQ4wQ=
X-Gm-Gg: ASbGncs5zHhpAO1oAeZnZgMwfpms3+zLRNMT0defqJ09uDY1QcNzRwM5eshU/Di+1LO
 fmmkh+SrVcUTRiWtdinWRv54KnDAEBEcCw0ajZYQCIJesPNB1LcntrngN1lQo64V0mszrc5m8nK
 LTs9uZZtgs4v/15ttgh2OZkGS74VdQDHK3E3xgRyp5cJY7iNI1HPwbajAbiyO5dYEmrS79SdIz1
 JEiLHl1JeGQkDutyYCbq/AnkSHNKw3BfaKMt3qhc/ksD62tq305Aaw8sBDrUx0/1wfnejVsifP5
 fMoZLS8yIXUyuPHf/imtxxK0A6oCA2MrO8+MDsVnDWGfc/aylJnHwGiO+2/eL35faDgQne/WSot
 f4j0Qj4py4Rp30H1hDRqS18AubKeK+YmKfneJAgY=
X-Google-Smtp-Source: AGHT+IEpQvfbeDhsAFTZq5PiSc6CG9uJR1866fYBcSAjSEDYwTyluX36X71EgluaChPxa9QzVFHE7w==
X-Received: by 2002:a05:622a:1911:b0:476:8eb5:1669 with SMTP id
 d75a77b69052e-4a7fcac67b2mr182711871cf.32.1751217938843; 
 Sun, 29 Jun 2025 10:25:38 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a7fc138d7esm46371731cf.21.2025.06.29.10.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 10:25:38 -0700 (PDT)
Date: Sun, 29 Jun 2025 10:25:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH 00/11] NXP DPAA2 driver enhancements and fixes
Message-ID: <20250629102535.154ea015@hermes.local>
In-Reply-To: <20250530071344.2939434-1-g.singh@nxp.com>
References: <20250530071344.2939434-1-g.singh@nxp.com>
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

On Fri, 30 May 2025 12:43:33 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> This patch series introduces enhancements and fixes to the
> NXP DPAA2 Ethernet driver. 
> It includes support for
>  - software taildrop on ordered queues.
>  - setup speed capabilities.
>  - DPAA2 resource version.
>  - MAC level statistics.
>  - improve PA-VA conversion.
>  - add buffer pool depletion state configuration.
>  - fixes for shaper rate and buffer prepration.
> 


At this late stage in 25.07 release, please don't mix fixes with
new stuff. Also new features should be in release note.

Please resend with fixes only for 25.07
