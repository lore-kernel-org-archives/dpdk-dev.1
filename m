Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EE8CD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 17:37:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F320C402EB;
	Mon, 15 Jun 2026 19:37:58 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 0C789400D6
 for <dev@dpdk.org>; Mon, 15 Jun 2026 19:37:57 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-3074adb8fcaso5661835eec.0
 for <dev@dpdk.org>; Mon, 15 Jun 2026 10:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781545077;
 x=1782149877; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0cd1dErf1+vF1cctStUw5L6t0OaE13gkAmYQdttjWrE=;
 b=PhI4SOTwa7izld/nGtJH/36IHVXf9/Vnzp/gzqKEDdNtQulIjgpxewiqMZfDpBYOc9
 lD6SJMJl9QotWmFRVtN2c7ZHjpDXhsOImLyZR8Xn+5GyvMiZrkmVbgDNZq9BF3cp52Ot
 sbukkNzMuO/VQcedXmINv/BYIEgaSEcNRNxyzYUcB2+s4dumaRHWdo94HHcXHZIVeU+I
 RUhhzw0sZz0mcIzabTesDZsUEaJJNe1cYx3HKytTsHwYsID7WmEDbjwxTC/yhGhGLAB1
 8dtARJKTmkNj9UxQqnfEepR4PnTmG3PWI50DpbLsN5UEK+2lVaV+cJCRC0MxSothaQTn
 KEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781545077; x=1782149877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0cd1dErf1+vF1cctStUw5L6t0OaE13gkAmYQdttjWrE=;
 b=a+srcGotcMw5zm6urA7BnCy+Pj/zI9UlTKokup5vD9YVOYHR7u2I+Dpe4Px4D6VnXj
 CpWGXbiIeKsfc3ydGqunrA9MFsDhcVWAOyKWxQ2bW9tQ2Ry0Yek3nFrz3UHFM06yhMJt
 w/mWWAW1J07BW6Jv0uJBZrXI8/c4Lou+2gTO0GzxJcWKMrFVzmgWHuVsOo5fJ83uhyEw
 8Df/jqlS+zOI+dannvj87Q6Kj5y8ZIJoHCW0A9rlfQ0WbgyYEdYz3Igc9Sj7kaa+GUp8
 DK9kLZfs3WCsT/FmO2etnjP7x6yZlXKD/MgXYeUI2OdbAQXvdFCGz+KsXxvcFzjE8LT7
 Riww==
X-Gm-Message-State: AOJu0Yw1oAg1irrAbfPmUK0m4DKa3dBfKU8EI4wMux+hG7InaTyE8OAa
 yPyynyKh2WPrEC/Q5OArl5CSaB2Umyk3EzijElW6VO/Wm0CDaG2gK47Xw1OJ64h6PF4=
X-Gm-Gg: Acq92OGNxoJsu9qo5prYZqewgtQKt47FDuJfHxJhoZpWVJnyEivtaYsiD/IHGL942Nz
 f1ia9smU1vn7vd9Pjb7KdSgI9LoRNsOK+MS2/a4+mBbWxKlN7c3AieeiWPerdkNjiix9/Dhe83m
 m6Cx/0VhohQO8d7edNd9FxpuXfI1k6EtcBMDIKkZTsW4dzqGeaXdCv4ARqe990pPWzD648RJ0y3
 Tm0OaZHnF7c6whEHuehWnk0c0V87M0N1Vf4pPIsFWWGstfFiohzGHxUN5UFh4vDdElJ1fhSbAxf
 zEhqslm623U/jr7pvgGMOCbKC4yOjV+5B/MMnWa2NyF5MZCILg218vqJq0Vb80ClaIJRVQENXk0
 4DeUtAIzVZjdqXm3VByN+Ad35OMMePvgNeYYvAL1ApjuhNnT8I8aGMwF3+lAINF9w512kB+1KAV
 Dl8mzQABJBXv/wVDi4r0OFfxwLznLri1qjRJc+dCPSm7AD0Yb9mh93JlxA87lBMXJ5
X-Received: by 2002:a05:7300:5341:b0:2fc:9ae6:e5a8 with SMTP id
 5a478bee46e88-3082009c394mr10220270eec.20.1781545076796; 
 Mon, 15 Jun 2026 10:37:56 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d0849sm17266698eec.7.2026.06.15.10.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 10:37:56 -0700 (PDT)
Date: Mon, 15 Jun 2026 10:37:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Samyak Jain <samyak.jain@amantyatech.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Vikash kumar
 <vikash.kumar@amantyatech.com>, Ankur Bharadwaj
 <ankur.bharadwaj@amantyatech.com>
Subject: Re: Question regarding duplicate fragment handling in DPDK IP
 reassembly library
Message-ID: <20260615103752.6155db47@phoenix.local>
In-Reply-To: <PN4PR01MB114326CC09306DA93ABA7C2ECEEE62@PN4PR01MB11432.INDPRD01.PROD.OUTLOOK.COM>
References: <PN4PR01MB114326CC09306DA93ABA7C2ECEEE62@PN4PR01MB11432.INDPRD01.PROD.OUTLOOK.COM>
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

On Mon, 15 Jun 2026 12:39:48 +0000
Samyak Jain <samyak.jain@amantyatech.com> wrote:

> Hi DPDK Community,
> 
> I am using DPDK 25.11 and evaluating the IP reassembly library
> (librte_ip_frag).
> 
> During testing, I observed that duplicate fragments appear to cause reassembly failure and the fragment context gets invalidated.
> 
> I would like to know:
> 
> 1. Is duplicate fragment handling intentionally unsupported in
>    rte_ipv4_frag_reassemble_packet() / rte_ipv6_frag_reassemble_packet()?
> 
> 2. Has there been any upstream discussion or patch to support
>    duplicate fragments while still rejecting conflicting
>    fragments?
> 
> 3. Are there any recommended approaches for applications that need
>    Linux-like duplicate fragment tolerance?
> 
> Any guidance would be appreciated.
> 
> Thanks & Regards,
> Samyak Jain
> 

Short answer: yes it is buggy, no it shouldn't be.
Looking into it but not a simple answer
