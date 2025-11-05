Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BCBCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 06:59:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1226402EB;
	Wed,  5 Nov 2025 07:59:07 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 415B840269
 for <dev@dpdk.org>; Wed,  5 Nov 2025 07:59:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762325945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8YCFs85vCZKi7bD2f0epLZ+s6bjdMx3afSR3VdP7eOc=;
 b=UhCPCOjQiD/I0lVSg90YPa4XZ/B4Etvc1v0Es9MKlbT7pSDTHg7PZBKEI9Rg4NmhvuHAq7
 T2w7F8oUTo+hhAnG/B167GoxXh4AHsFQ3l4V/5S4TYaps/xxAGNMh8rSjOjDqC+EmEW+Rl
 ZBR6bYLJWkfpvhsrD+1UJ8zNEhvt1+8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-gP4uZxIDPcqj0GqN2D4EAA-1; Wed, 05 Nov 2025 01:59:04 -0500
X-MC-Unique: gP4uZxIDPcqj0GqN2D4EAA-1
X-Mimecast-MFC-AGG-ID: gP4uZxIDPcqj0GqN2D4EAA_1762325943
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-37a3c96acf8so3931001fa.0
 for <dev@dpdk.org>; Tue, 04 Nov 2025 22:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762325943; x=1762930743;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8YCFs85vCZKi7bD2f0epLZ+s6bjdMx3afSR3VdP7eOc=;
 b=xA47/Sp9Q9zPYIQdqCqypuRzJ2+MOa/AvPfpSbBdAprCiS159UBAT0RcR8yebghLw2
 gnK+0398PlemRr0xm6ti98uIhWPwnPJHwsorX/pc/is/m+dt8z+qXwy607TgingLj1/Q
 iNsMFjbLMY9hD4a3qKJJFdENuG8I8yqDrgZJooG74nvH2eRwjMl2L775N/08wh3XD70K
 4wgMlfUpsFVxp6VA+AKThkFlB5KL4lMijjgQQJHLgJRiL+g8s3WgjPkZkaDWz1PnzQDj
 N6ebf+RKgLnnCcYLrWi4LJaJa+odgSAb6V7kTqTDdpr8sMLD+NzlukO2HmtF+k78kWdF
 xfKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4SxPn8m4nzBOrIJ0NAhQ5MRC0AtNkjr+PB5MZli32RVEXlanRslR0Z1XsI0CjCYm4rAg=@dpdk.org
X-Gm-Message-State: AOJu0YzJ7d+ExJNMamGZx/FicrVb90asw+AomlAfuO5Zw0iMzX/kaIL6
 X+SShWPGoQLzlZqXXpcXEqEx5G/E7ROMg/JJPgSx6HoxNpSLQUhjMvbGV+9sKR+JrAEs/jqRw9c
 rCCKS6+EDgqj3Ss8/4HBbSh66Xfw96hBparigNn83QD4ElvxN9phlmMcmM82QadfQ7cMMrJrau2
 Jwem3TU49OEx8Qp+/9O9E=
X-Gm-Gg: ASbGncvrGprg2LVMoqa74V6+Z+hgnQTUxVMq4+05xRUk0m2iIEqMzBsV3+FPq1LJQar
 0ZUJ59r6cqFuN0OABbgg9nD3EH9V3vIbagOJQxsPAADcS8MEXZudL2igjiee3WUxZ32e/+tbE0M
 7viHU5/orsRtwxi4eazvMFPZaAlSNqNMTipBqqRTCoM19o0k0bYPEQsU7CLA==
X-Received: by 2002:a2e:b888:0:b0:37a:3910:6c77 with SMTP id
 38308e7fff4ca-37a43078ab4mr17286811fa.5.1762325943057; 
 Tue, 04 Nov 2025 22:59:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWZb2hKiCztgQt1wCstlaTQNfQbAjpJPG9HqdrAdIjzQ47+5pPDpUYxNtwXuttRxMX1KUx9Gjp1HphgeurLBc=
X-Received: by 2002:a2e:b888:0:b0:37a:3910:6c77 with SMTP id
 38308e7fff4ca-37a43078ab4mr17286741fa.5.1762325942658; Tue, 04 Nov 2025
 22:59:02 -0800 (PST)
MIME-Version: 1.0
References: <20251006051402.1387576-1-rkudurumalla@marvell.com>
 <20251029130023.1637177-1-rkudurumalla@marvell.com>
 <20251029130023.1637177-5-rkudurumalla@marvell.com>
 <CALBAE1Nboip1UhNtQkUTkdPareKEekzJCniK7E3WD1s4sWLr2w@mail.gmail.com>
In-Reply-To: <CALBAE1Nboip1UhNtQkUTkdPareKEekzJCniK7E3WD1s4sWLr2w@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 5 Nov 2025 07:58:51 +0100
X-Gm-Features: AWmQ_blm4chF5D-D3t3nrpBo_XJDC5mDF6AKhdTp9XOyH-PDL7CKsOsXD5EB_9o
Message-ID: <CAJFAV8xHO0V=DkCuY=tMrXkPO28ebV9Cf=c+_k4qwkceXgspqQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] net/cnxk: enable CPT CQ for outbound traffic
To: Jerin Jacob <jerinjacobk@gmail.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, 
 Harman Kalra <hkalra@marvell.com>, dev@dpdk.org, jerinj@marvell.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vKPhHCTzklmSM38ySyhWbmnerAgNQGRH0TapisQVRio_1762325943
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 5 Nov 2025 at 06:11, Jerin Jacob <jerinjacobk@gmail.com> wrote:
> ### [PATCH] net/cnxk: enable CPT CQ for outbound traffic
>
> __rte_packed_begin and __rte_packed_end should always be used in pairs.
>
> 3/5 valid patches

My two cents, this one seems to be a false positive.

struct __rte_packed_begin cn20k_sec_sess_priv {
        union {
                struct {
                        uint32_t sa_idx;
                        uint8_t inb_sa : 1;
                        uint8_t outer_ip_ver : 1;
                        uint8_t mode : 1;
                        uint8_t roundup_byte : 5;
                        uint8_t roundup_len;
                        uint16_t partial_len : 10;
                        uint16_t chksum : 2;
                        uint16_t dec_ttl : 1;
                        uint16_t cpt_cq_ena : 1;
                        uint16_t rsvd : 2;
                };

                uint64_t u64;
        };
} __rte_packed_end;


-- 
David Marchand

