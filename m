Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7090CCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 23:20:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A21BF402C1;
	Fri, 17 Oct 2025 01:20:21 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id B0A4A4026D
 for <dev@dpdk.org>; Fri, 17 Oct 2025 01:20:20 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-88f26db50b4so182199985a.2
 for <dev@dpdk.org>; Thu, 16 Oct 2025 16:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760656820;
 x=1761261620; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C/gM09EXQMdBsWFzhfiOUQ8tKWF/44cePAD6F1XE6eY=;
 b=CMGBIdd2dfvkBZ/Sk+t8BkPeWkre3hOSRYcmuFT7rXesaVGFyxDXUQ6rBmM7h48cfX
 fkTVMqrkQHfYpsjQr8jexcZqQEqMMAwk6mS9AwB7IFiCk8eoVgMKUl8sdMYBueW7vjdt
 0/Y9pQO/90W4vVUL2QLz8X0MCYm1yMd3EgNc+95QKK0Og3g6l3sTuYeEkYFkrFZQjURC
 tGSGa1rLphSf5zc6I2XPY3FPV9aTbl25s7FQLch+hy5Qk9M+VC8JX/o4vix4sDw64k9W
 V2BP/+gj39JnbaWobffjYnTNQeKiDJD7daYyJZaZ4flqw57Im+2chKX/67HGxdarZ7Ev
 2+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760656820; x=1761261620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C/gM09EXQMdBsWFzhfiOUQ8tKWF/44cePAD6F1XE6eY=;
 b=aOMEkL3ddCdGug0TXkqKZAhUojM/7tQMGTIXL/aTMLHhp6EdVr1RvS8agp4fXT9tUJ
 lY6NCRjdshZCNnR0G9sEAHVKLbxE11/qG7IMgomDZ9tJVzIXtZvWhgQg3cxvvtePfoUM
 nbdqkrIaNcuWl7947cJUgp5jyf0tSACjeBJNgE6I/lexmQMOsnGml23FCM8I7My1yEHN
 zft2ybKN+QJh8SJToHy4LkY89sPQlrI8MAi3evmthRobedVblzTS6dmUG6oEJEFM26um
 xWfOsNATFHYgg+x8aKBDyQq/MLrtXtfDuiYin62BqDgV22EuNnozkhPZXL0zXfeADEvO
 nC2w==
X-Gm-Message-State: AOJu0YzVEOtEqO2M94c5wsVxK1je05qltmYxELTDzQyta7WmmBYUIf9m
 d2Z0PGsW9gK/O0ZG08E2m6FL9VHMNe4lKBJgtUY3RqV9hec00NdZwt5hXv5GWB+zcbk=
X-Gm-Gg: ASbGncsHSYAWamnPiM2hrfG0oDxKG3Oze0Az6udOgkgPUq4/IpXed9inapFxt9jJtmY
 EHjExik3FmhS6FZSFAQC6JA/RBNy/mrt7RB24k+eFAQzClov/79I5Ldyrn/zsyZUMCVBwWnJLHv
 p/ngT2agWyxLlEZ5RPjLV9f5YESHHfi7+/wJNvW4kxO9feSPySqbgTsU+Nbz72n6n40Al2oBTUJ
 VUf1PkT/UpvKo13mhhIixLdkuNQ9kAfh9kY0d7oheeZpVtWdWMnwSP49nmk3ZtEbdnbPMm6xUvi
 kSDOekyjWmzKwLOU7nzDauAB7yyrDbpBLlu9c7g4siavP0RZjrd1nZqDqRj4A9GZAHvwM6XnK81
 ydeGzbm1NnQYb77fTu9cOe3vi6j44NESBxUaA+PfSa/YOrY10jt6iNVLkl+fdbv4Rou6zAyDQ12
 KCa80WCQv/Nn8mtVzZe9a3YeK/tR1P9dFsWF3+6+QKhbZjpO5kXkcg
X-Google-Smtp-Source: AGHT+IFHi5qWiyIlllmaTE9mkX88SoT+itIjlzpJbj4Uetc5ZD1RzvkzKG0ZfTJzxELuWYZFuCPtBw==
X-Received: by 2002:a05:622a:181a:b0:4e8:97b1:2f1d with SMTP id
 d75a77b69052e-4e89d3a1f6cmr29323761cf.57.1760656819746; 
 Thu, 16 Oct 2025 16:20:19 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e881d1adbfsm52067211cf.34.2025.10.16.16.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 16:20:19 -0700 (PDT)
Date: Thu, 16 Oct 2025 16:20:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: dev@dpdk.org, david.marchand@redhat.com
Subject: Re: [PATCH 00/11] net/enetc: various fixes and enhancements
Message-ID: <20251016162016.7469ed86@hermes.local>
In-Reply-To: <20251006080410.1433284-1-hemant.agrawal@nxp.com>
References: <20251006080410.1433284-1-hemant.agrawal@nxp.com>
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

On Mon,  6 Oct 2025 13:33:59 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> This patch includes:
> 
> 1. Various fixes as identified by NXP internal coverity
> 2. packet parsing and MAC address support
> 
> Hemant Agrawal (10):
>   net/enetfec: fix file descriptor leak on read error
>   net/enetfec: fix buffer descriptor size configuration
>   net/enetfec: fix incorrect Tx queue free logic
>   net/enetfec: fix checksum flag handling and error return
>   net/enetfec: fix to reject multi-queue configuration
>   net/enetfec: fix memory leak in Rx buffer cleanup
>   net/enetfec: fix to add check for Rx/Tx deferred queue
>   net/enetfec: handle cache for forwarded packets
>   net/enetfec: support to set MAC address
>   net/enetfec: add software packet type parsing and cleanup
> 
> Vanshika Shukla (1):
>   net/enetfec: fix out-of-bounds access in UIO mapping
> 
>  drivers/net/enetfec/enet_ethdev.c | 103 +++++++++++++++++-------------
>  drivers/net/enetfec/enet_ethdev.h |  59 +++++++++++++++--
>  drivers/net/enetfec/enet_rxtx.c   |  27 ++++++--
>  drivers/net/enetfec/enet_uio.c    |  11 +++-
>  4 files changed, 140 insertions(+), 60 deletions(-)
> 

Queued to next-net
