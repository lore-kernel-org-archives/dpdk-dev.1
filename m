Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D29410F995A
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 16:38:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABFC6402EE;
	Wed,  8 Apr 2026 18:37:59 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 641D8402E9
 for <dev@dpdk.org>; Wed,  8 Apr 2026 18:37:57 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-354a18c48b5so60194a91.1
 for <dev@dpdk.org>; Wed, 08 Apr 2026 09:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775666276;
 x=1776271076; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eK1Xh0SolcAAyZHFhYxxlW6C5Lkx52z5FJJgk8X8+CU=;
 b=SeAQqpmKkL75i1z58o+zue6+Xtpwihxe36LnQGJoUjKnZDTRdXiPWXT5UEmT+wnmEn
 08Q7gJAu6vlySON7Fmahz0XazDcnkKFPbnp0+5WJMRP+SCjW+oSr4QNKDk1e8of/j+g6
 BqvQ6tNZE+eNIJ4P2sFoNRrqvj1fsKTd0B/kJeaEhO2A977qDtKyI6WB3qvFful65LX+
 KYu2kssA/ALeWMdGnpWOTJvMrmCp94u3M2URhRFXf2aDHNFQhbTnCilmeBdiY/vqAOMZ
 8ggcnEBkXeL6OGWX8Ya50xgf5CUqQ6ms5E1+3YjfxxymtnCPXoAO9uJyZeGiGx+gBcRD
 J0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775666276; x=1776271076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eK1Xh0SolcAAyZHFhYxxlW6C5Lkx52z5FJJgk8X8+CU=;
 b=TwQRhycKmADmdkAc0s3mS1oIpFXBm9Lkgi8tpRxisy1eu0iXm+kMt5trHbEjQs/RLW
 rF3Z/Kh5ssIto9DVQuUwty2Luor9FDa4ii2xBTPC1Kr1NWoSpod4MwdQNSsER/Fw/iyW
 l+LB1pDKyI91hEb02gqvuhSH1OCL0Aiq5ErVZZQjSpUambZP1sxyGqFJdvS7FAqhTn1H
 QaCw2WNL3pMeQHwbDRF/pZp+ldX31qUAKVi6ZuaN3JiYHcPZ3XNulzXlWsPeFXTdSF5E
 MjxQtP+Xjae5JqCvQV0MPYLOJutf+mCfKde7iKIDOFwoMe9qawsAbAkLyjgHticI62ia
 i1Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEe6C2/AAe43GBcgVqzxM5UxUyH5zYbHJBAarRzYvuJTyyOANfsJjQV/6a8qqAgeaUOEQ=@dpdk.org
X-Gm-Message-State: AOJu0YzTQKcPc+XRYOrCXUT7WRDwTNhlgLKiFCpT/YIMpqWb7ZTYIH6Z
 F7YBwkwSNoj2lLGgMdAwqWFDBXungtHriuGiMWkt9DawrVDURN529EkFqrHLlFGyyEU=
X-Gm-Gg: AeBDieulghzqfoxaICvmN+7Xm13uznxZHAQoGfU5gw0/x7wHw8eZjkXuYLnzoiw1d5g
 dPM4Jl5KJHKlDuGACRLb6+hITVMeFAqKrNjW85VXW2ajkUYgv+KjhLVlOsyBD/aPwNVqgVjTQC3
 VgJDbKXECxU5i5OsjJPRl94Cb2sJbz1pbhmaU7IRUXRcP6bPppW//3hZ/L49CZ1xbjNKQQupkR6
 IuyceUlhqYglwlErRY9DcoV+NBpxQsM7l4OM8VKRgNivX4oztX/E2RD4bKgjX2htjap64BcJ7LB
 Oovoa9TR6OFf3fRi/eMUG45jJmhz4iFfnXnJSRbFIe9DlRM7gqLzlzXStn3+cuxQCAYkFlEZzfP
 YPWKYgLEqz6z1z6Ug7A2SdyzLUHV+RZ1hYhoILcyJspXiMno2MYBUzlSyU8m58I+oim04nLST/e
 53AejjLspsEO8VR8Abh9Gb8/5YN2nQMr6Gzp0=
X-Received: by 2002:a05:7300:c618:b0:2d2:b3a1:4a89 with SMTP id
 5a478bee46e88-2d2b3a1657amr2489353eec.30.1775666276275; 
 Wed, 08 Apr 2026 09:37:56 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7d00f5easm20512926eec.29.2026.04.08.09.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:37:56 -0700 (PDT)
Date: Wed, 8 Apr 2026 09:37:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: Ernesto Ruffini <eruffini@outsys.org>, "'Gokul K R (MS/ETA7-ETAS)'"
 <KR.Gokul@in.bosch.com>, users@dpdk.org, dev@dpdk.org, "'Nivethitha N
 Shanmugasundaram (ETAS-ICA/XPC-Fe6)'"
 <NShanmugasundaram.Nivethitha@etas.com>, "'Aloysius Nishanth Britto
 (MS/ETA7-ETAS)'" <Britto.AloysiusNishanth@in.bosch.com>
Subject: Re: Issue with DPDK-Burst Replay =?UTF-8?B?4oCT?= No Frame
 Transmission Observed Despite Successful Replay
Message-ID: <20260408093752.109d2a61@phoenix.local>
In-Reply-To: <3183bfe9-1133-58e7-1387-88b85cb8e623@arknetworks.am>
References: <PAVPR10MB73554B90C65B0D9A83AD8582A450A@PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM>
 <5a8c61fe-9c47-d74c-7e0c-3f8dd47b3926@arknetworks.am>
 <PAVPR10MB7355DA0FC9C2847774A0096AA45FA@PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM>
 <63d4634b-d09a-13bd-86c0-593147e8e874@arknetworks.am>
 <ae786850-6920-c96b-4fd0-89200b78003a@arknetworks.am>
 <PAVPR10MB7355B7E86E0F65E0F77579DEA45EA@PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM>
 <945b5f86-c309-ca09-3764-ad6cd1e0ffa8@arknetworks.am>
 <PAVPR10MB73559ECA8CBD947C9A80D111A45EA@PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM>
 <ac43a41e-299c-d8ab-3198-116e7d5a128c@arknetworks.am>
 <PAVPR10MB73554E72245AA0D44E9822D7A459A@PAVPR10MB7355.EURPRD10.PROD.OUTLOOK.COM>
 <002d01dbfd46$034170c0$09c45240$@outsys.org>
 <3183bfe9-1133-58e7-1387-88b85cb8e623@arknetworks.am>
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

On Fri, 25 Jul 2025 14:39:49 +0400 (+04)
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> Hi Ernesto,
> 
> On Fri, 25 Jul 2025, Ernesto Ruffini wrote:
> 
> > Hi,
> > Did you try using usertools/dpdk-telemetry.py?
> > It attaches to a running DPDK process (so your sending process should stay running and not close immediately), and can show many counters, including packets output by a device.
> > At the command prompt, you can type "/ethdev/stats,0" and it will show all input and output packet counters for each configured queue in device 0.
> >
> > https://doc.dpdk.org/guides/howto/telemetry.html  
> 
> Thanks, that may indeed be helpful. But even without a secondary process, just
> inserting one invocation of statistics API and a printout to the port stop
> sequence of the target application would suffice to show the drops (if any).
> 
> Thank you.

The DPDK dumpcap tool also adds statistics at end of capture into the pcapng format file.
