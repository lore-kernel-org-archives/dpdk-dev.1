Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210B0C369B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Apr 2025 16:34:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DC45400D6;
	Thu, 17 Apr 2025 18:34:51 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 902EB400D5
 for <dev@dpdk.org>; Thu, 17 Apr 2025 18:34:50 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2240b4de12bso15696035ad.2
 for <dev@dpdk.org>; Thu, 17 Apr 2025 09:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744907689;
 x=1745512489; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QITi4uZXa6/27h4rQU1XwDgvCbOiGZwSnT/l4AZl8WA=;
 b=Ws+Lhv6/hZ7PzbwM2Ig8+E1jGotJfBp3wZU7B+JoGXb8ilK5xbJQ5sLMXR9HftxznW
 7petA69WalF21Mimd2ni25QiZDMBhnvp7o96sEAXcm9H5HS/ffiFsa/fJl0XwRVbCFYZ
 CBUGHvguHraavzCk4CeM6odEjVbuQ++M1jwlZREF0J55WYVi3rrGOhl5Dx4rGUtgRfvU
 7sHA7xgz6jhj7N/n90pdbBj1KA1uiBVbg4ANtkHD31gb55w7SfhpA9O+KuIKs7bjp47Q
 gVFXsm7+9T0AeOfURifHQYCfpbVdpyXwxEwPQsKdMeeOADr42TTxHPq1Q4INdQZXPQ64
 YDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744907689; x=1745512489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QITi4uZXa6/27h4rQU1XwDgvCbOiGZwSnT/l4AZl8WA=;
 b=RFSmWIt6sOnmmyX1LPkQrtxcjLN0jx2RGltYMCYvLs6v7b2ZjJqd93ZB5fH6QKoXKN
 izsUiHDd+7YZdItxnp41aDzizNarSfsYBlECQ8hOG0wJGe0BWaF2Si0o+4j5Uh6sMY/z
 vJrHaNTncYvngksrUpjHgK3gk9oKXmJ7Ez8RfAcbgPJvbkyMLN4eBu+1Pq4bK6UryPIM
 OPK23KjAL2tSRYlH5VCQFPGi77ivM9AZkyY8UmEJC3kXM/MYW/uK96x2GGXuWDgYwdCT
 SCXZftBLww58m4HDv5ZJ++KswxH7dHiTbkHe2wZK/F38uX0XaU+Qhc0VwLTdHvy6YStw
 d/WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc9XLhqCv9qYNlKc9ne70RuN5eMipQ2+9rYO/Y5ROQ7yRTB1Xi741LNbVnAnYDZIpbM7o=@dpdk.org
X-Gm-Message-State: AOJu0YyFF9D4vjH3zzcArDzH11fNwJn/fNc5Z7NnUs4y2AKlgJx+LyE3
 bLUsIzLUlkXbaH/SEXalr71dbmS2JHFcDK+tz+RypHvQhgQLaiuxdWJLHx+zwJI=
X-Gm-Gg: ASbGncv9ZDA/W33qnMpFD6ollOfJbkR6b8SpfvbBTJGyybnMy9/1CZDK5ZMiuwc5f+k
 rN770jBiTWRgOO+e/UBH0GEA0P8HFDc/3f8taG7p8LDxlrMW2HpYbw3XUX23aRNalJVCK2qW7Ce
 bhZNBPQUbx/pQcifqf00MNE4n2NHToWKtwkftaj9EhEEm/ahETfwBu9Sw2aSdbBQHOZPoUcg+PZ
 KDJLQ4vQmf0COc8j0GMF+G2FJrRtOaE5jERmUAVG78Pcd4EnJPpKy/2SKc0ekZMnmzNT/+yUWmq
 Cy3UsZndXvcVmQ21oxM6DlalZWEK+jiBvNKOsz3+f+he+Y7KaRJTgIIdi+YMEE8GX1KHSST3XpT
 dBMGqqDLHW1Rxsr9H
X-Google-Smtp-Source: AGHT+IGOGSTFb6CX92xEbo18+yhxBVdAPTnzDkfbym9ZmmGjzVYyM1m4P7dVSZXUz87SxXMCZPosLg==
X-Received: by 2002:a17:902:f546:b0:227:e6fe:2908 with SMTP id
 d9443c01a7336-22c359a2580mr95441805ad.48.1744907689622; 
 Thu, 17 Apr 2025 09:34:49 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfa59165sm39653b3a.93.2025.04.17.09.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 09:34:49 -0700 (PDT)
Date: Thu, 17 Apr 2025 09:34:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linuxonhyperv.com
Cc: Wei Hu <weh@microsoft.com>, dev@dpdk.org, Long Li <longli@microsoft.com>
Subject: Re: [patch v6 0/6] Support VMBUS channels without monitoring enabled
Message-ID: <20250417093442.743b3daa@hermes.local>
In-Reply-To: <1744837038-5387-1-git-send-email-longli@linuxonhyperv.com>
References: <1744837038-5387-1-git-send-email-longli@linuxonhyperv.com>
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

On Wed, 16 Apr 2025 13:57:12 -0700
longli@linuxonhyperv.com wrote:

> From: Long Li <longli@microsoft.com>
> 
> Hyperv may expose VMBUS channels without monitoring enabled. In this case,
> it programs almost all the data traffic to VF.
> 
> This patchset enabled vmbus/netvsc to use channels without monitoring
> enabled.
> 
> This needs to change the APIs exposed by drivers/bus/vmbus. Because those
> APIs are used only by NetVSC PMD and not feasible for use by a DPDK
> application, all VMBUS APIs are set to deprecate in upcoming 25.11 release.
> 
> The notice for deprecation is accepted in the following patch:
> https://patchwork.dpdk.org/project/dpdk/patch/1742242184-19600-1-git-send-email-longli@linuxonhyperv.com/
> 
> Change log:
> v3: Add in the comment on the VMBUS API deprecation notice
> 
> Long Li (6):
>   net/netvsc: introduce private data for storing vmbus device for
>     secondary process
>   net/netvsc: introduce get_vmbus_device to get the vmbus device
>   bus/vmbus: store UIO fd for secondary process
>   bus/vmbus: support channels without monitoring enabled
>   bus/vmbus: add rte_vmbus_device to all functions accessing vmbus
>   bus/vmbus: set event for channel without monitoring support
> 
>  drivers/bus/vmbus/linux/vmbus_bus.c  |  9 +++--
>  drivers/bus/vmbus/linux/vmbus_uio.c  |  6 ++--
>  drivers/bus/vmbus/private.h          |  2 +-
>  drivers/bus/vmbus/rte_bus_vmbus.h    | 16 ++++++---
>  drivers/bus/vmbus/vmbus_channel.c    | 53 ++++++++++++++++++++--------
>  drivers/bus/vmbus/vmbus_common_uio.c |  9 +++--
>  drivers/net/netvsc/hn_ethdev.c       | 44 ++++++++++++++++++-----
>  drivers/net/netvsc/hn_nvs.c          | 33 ++++++++++++-----
>  drivers/net/netvsc/hn_nvs.h          | 21 +++++++----
>  drivers/net/netvsc/hn_rndis.c        | 11 +++---
>  drivers/net/netvsc/hn_rxtx.c         | 16 ++++-----
>  11 files changed, 153 insertions(+), 67 deletions(-)
> 

Applied to next-net with some minor shortening of commit subjects to appease
check-git-log.sh
