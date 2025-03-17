Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1169CC28B30
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Mar 2025 13:56:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0321E402DF;
	Mon, 17 Mar 2025 14:56:15 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 5417B402BB
 for <dev@dpdk.org>; Mon, 17 Mar 2025 14:56:12 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-224171d6826so31897975ad.3
 for <dev@dpdk.org>; Mon, 17 Mar 2025 06:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1742219771;
 x=1742824571; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aGa+xEiXpa0BHHbsmgIh9zUyH85ibEECDcr9RvJq3qI=;
 b=EMe9wggb936VrRVy06LuFja/P/znij3rYwkaJ9eVTpK+D40EI8LF9YQiwJCSx86uHZ
 cn2OjEcDMZ87EmYMcSx+ge67Ov3DwsyzHqaBwq0l8JxoJK2gU4SRTY2kzpaQ6nF12eCr
 eaHCDqBT42gOL/VwuAWKCjR1IFUiFC53GGA9BSIsKLtVmo5IaK9mhDJ4Qw0M+NGnz2Dm
 AMzqaFeL6pwR/LqncwZeav5NCFEaHFLNzFBxAe0OVf6MIcm8oFKxHMkSZ3ge5Uj8LRYQ
 g9EmtRfhgPtbjaY+VhfVAWde6LKrAmy/vAld6gWeMpxY4tYsodn3Zz9i87xSKK9lD0Md
 fN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742219771; x=1742824571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aGa+xEiXpa0BHHbsmgIh9zUyH85ibEECDcr9RvJq3qI=;
 b=E8Ascb/QY5kia8/F5hDhPcYQJaaBA9KQFVHXOVoPUxOkrhvP05Yx+dlMJ6WMKlb4oF
 9VVJvkeibUUclBi391m6buM3gvj7hyk2VSBAJzmV5wTNxMjjs67Piv4WUmwu36ZP8qoN
 f+2tNHwJkG0VSoO8gIH3sym981+1wdUyj2KMlypR+1UjzCEKRUJtMguEmxbJMiyTh8B1
 w2lz7EIGghK1iUGqARzLvg6byA7NVZhnSYQ9oXJPxTJW+ADa3Ghxuhq6Lhg1varNwPIe
 cJ/dn38UDYIc3ncolQzFt2ZkZrxxrh10Z4TIjOmgE2Qtv/ZoGBP5JDVC6C98Qvr7gZj5
 n7zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN+JV+3BBO2pibSWyrQ7tyVfWwR7iv7bxqOLbJV22OOX163ILMsw2xFwV0Gm/Enw3hr1k=@dpdk.org
X-Gm-Message-State: AOJu0YxOz5weIs3AjhllIbN3c3qQYmJloRpnxJgm6dQu5m824ckYABcR
 SkYSWMd1kQFr17WuyxfLNjX14Z9MJvb0AiIuEVCoFjOTtxEo7fj/lDDJqQLrwXM=
X-Gm-Gg: ASbGncszz1K3GC9Khg5mqHuR9QJs31qOCewKUz77a/MjtVDCYI/ptwTdX7hxcD6Xt+U
 y7NqWEbRpvSjsuw8AsoBAF+xbbvk/N1Fb24gUIFtPNEZn0apl6ji65J4JaaryXGLHWENOqVk5v3
 pHyB6W9RBJPcgWtEzhJH1jOZIwQvYAWZoQQ3jgMQXzwb57WbhYYDE99yapNTQNSK7V5n6y2M7c7
 V9JN5IusQ52dnZsphHXumM7IWGQxEylVhJH2IBfjYFLpqQCIoPFDumoh2luYOXbEm1TCiAplTPm
 DT7z5uHXYTDYaJ5F7m7pjdBB/nWOg99jxlGJhC+yQWQFdZA3wmCCaBOYRJa2eS2tHplF+G4h3MH
 0KKl3Ucv0YogteHdoJZZwu/ZlOa7UxXOP
X-Google-Smtp-Source: AGHT+IEJ+hEvjbmEmBGRVUCEO9xG5qYSF93GZWP6RHumNqslww23XcYBIdBdjGr3KsMKpzkrD14SMA==
X-Received: by 2002:a17:903:2a8f:b0:220:efc8:60b1 with SMTP id
 d9443c01a7336-225e0b185fcmr174043945ad.39.1742219771377; 
 Mon, 17 Mar 2025 06:56:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c688866asm75429905ad.50.2025.03.17.06.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 06:56:11 -0700 (PDT)
Date: Mon, 17 Mar 2025 06:56:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yang Ming <ming.1.yang@nokia-sbell.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>, Bruce
 Richardson <bruce.richardson@intel.com>, Kevin Laatz
 <kevin.laatz@intel.com>, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] eal: prevent socket closure before MP sync
Message-ID: <20250317065609.79fa3ad7@hermes.local>
In-Reply-To: <20250314103638.2198-1-ming.1.yang@nokia-sbell.com>
References: <20250314103638.2198-1-ming.1.yang@nokia-sbell.com>
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

On Fri, 14 Mar 2025 18:36:38 +0800
Yang Ming <ming.1.yang@nokia-sbell.com> wrote:

> The secordary process should not close socket file for MP
> channel before performing MP request synchronization.
> This prevents error logs when the secondary process exits
> without any operation on the crypto device while the primary
> process starts the device.
> 
> Case situation:
> eal_bus_cleanup has been added in rte_eal_cleanup. But for the
> secondary process, rte_eal_cleanup firstly performs
> rte_mp_channel_cleanup, which closes socket file for the MP
> channel, making mp_fd invalid. Subsequently, eal_bus_cleanup
> triggers vdev_cleanup, which calls mp_request_sync to send a
> message via the MP channel. Since mp_fd is invalid, error logs
> occur.
> 
> Error logs occur as below when the secordary process exit:
> EAL: failed to send to (/tmp/dpdk/l2hicu/mp_socket) due to Bad
> file descriptor
> EAL: Fail to send request /tmp/dpdk/l2hicu/mp_socket:
> ipsec_mb_mp_msg
> USER1: Create MR request to primary process failed.
> 
> Function call trace:
> 1. rte_eal_cleanup->rte_mp_channel_cleanup->close_socket_fd
> 2. rte_eal_cleanup->eal_bus_cleanup->vdev_cleanup->
> rte_vdev_driver->ipsec_mb_remove->ipsec_mb_qp_release->
> ipsec_mb_secondary_qp_op->rte_mp_request_sync->mp_request_sync->
> send_msg->sendmsg(mp_fd, &msgh, 0);
> 
> Fixes: 1cab1a40ea9b ("bus: cleanup devices on shutdown")
> Cc: kevin.laatz@intel.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>

Looks good, could there be a test?

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
