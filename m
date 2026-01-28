Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65465D46BEB
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 18:59:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3C214014F;
	Wed, 28 Jan 2026 19:59:28 +0100 (CET)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com
 [209.85.221.175])
 by mails.dpdk.org (Postfix) with ESMTP id 2C9444003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 19:59:27 +0100 (CET)
Received: by mail-vk1-f175.google.com with SMTP id
 71dfb90a1353d-5636b2fde95so48499e0c.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:59:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769626766; cv=none;
 d=google.com; s=arc-20240605;
 b=QlfrpNH4L80A/o259Pa0B6DNxCJ1eqAdT29jizc12u1YPZfu21BMaMWUJ4YLUxJaBQ
 FXLTTuWqXPtTR0V4NL0cAd9uWJBJAYZVIFOJWJkioo09jHbDbCj+hQVV8lg9hSrCObdN
 HO8YMiYYUzbUrFG3Lcnagjj5VhqRLSKLr71YqISllE9jzu7aKdcERYt05HulZZI3hOCY
 vh2NBtJR+MmwKxvnzpZBHVNrzebK6p/+TkLO/e2DZUhr9dx4sRWt25IM319FpkSkpHhT
 +mnYq9x6VZCXMxhyS+twTAU/J0V3gkqOXbqs1p4V062hzHI4ZA5+VlesleoPT7Ow4A5D
 AABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1sFIxVYsDFDC9Gz0vi5F5tI6Sma+sBMcG37imGoXwSY=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=Cj8gim/syutHbyf+eulwEH6lns0b2RmD9eG1/Mfr8ssKpC9OZy/6ebuL+dvJ3M2MmD
 t6El2XKPpky7hKN/1uaPyBfa39Nct+6upudQHTBOlNhhbyHNTSa6GF2lB9FVxIARS+VI
 Yk6T4RF7xbh6oYhfj9lRR+m3X8wRUATiy0Hv6L6C5il+NMRLYUmES9JvheT856K89d2s
 uW8sb1dBiAuxj73MWIe4up4yQA+fXIXhz433yTgswKYz+TXqzBMkbCgBYtbbS8HsTUVp
 KMKjOE13qeQgGFHPXvMCeSxzM1xrKRLQ5E6nmnt/Y39mUfvjRj/CWJK7c3oNKzsxjM77
 Pjfw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769626766; x=1770231566; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1sFIxVYsDFDC9Gz0vi5F5tI6Sma+sBMcG37imGoXwSY=;
 b=TENnGaT7x0EqZujWIEesnIDBLMDrTeAWjHD0iSIbYet+aIVTsvPb81HNBAy7sRJwHv
 V/NScKSEgaBguU75C1h5p1W9rXqOxe7KGYWw9y2OJDrGzFiBz3jYHhEwT9YSnttlg0W8
 Cn+QUZAfVuk0kQSsAeeEUdi39uGKvH4o05Xd8zpavWTPUCkBpibA2XXf1K55yS9KtFNb
 QDK3rm+D2IFzbqyZbPAUlFwyfZtXCxikBMuUMN4jz2WW4P6KYcu3wruCIZLk7efBBi0v
 bIwqHHqnqblStrsFiejMNx9z3mVkb25gchdM36UfCokmnVHKWNRueO+IYetHOsYchjch
 i90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769626766; x=1770231566;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1sFIxVYsDFDC9Gz0vi5F5tI6Sma+sBMcG37imGoXwSY=;
 b=Z6RERz+ItinqWS4+R08L09OFu13/EHdzabefrsl19tnmcbMSyoM4vtCL5u0tFmG1Qm
 U5fgeCtKJK6jSMSGPj1iO7PBxEi3MHq5ixVdmSPSaiKrXh7uW/YAftki0Zwb+6GE82OH
 LABpunaeQeUJSaDBG0FAhgbdpgCQKJpywyx1RRi+hMcXBNg44LSk5bEIgIik2fpUyDCx
 fXX4pOduHPlLEQ8cRcemYE5JUpSztTKM7MmfVIH6l1cDobImd6eMimKNL5ZM/vErnwwd
 f6cr0wKhtK8b4ZpPjtZS6VzKs8aWkl8xNJt0BKRc3Bv67mF9Ds/U7JVsdstrUhTGE+Yl
 ZkAA==
X-Gm-Message-State: AOJu0Yy0HqVxUGlxyM+VYKHrsEWUXM4qhaKV+YKPevfukhHu2RxtTOTZ
 Mvs5QTKVYXsnCX8Hx33OZehVABu+Df/TI46PAF8w+Z/Rcy6gHc5DvuEs9WVqnz/tlcfL0mtGUYj
 GpG4SclTldG4CjvGTiSGz8ajPaH5yuAk=
X-Gm-Gg: AZuq6aLMG3TtN6XRc+Jd+Cx4aHWvG5zya35w9uX4Hdzwn98/sxqwyIBp4r8m5mooVw8
 OHL7BRl10v2XGrhn+KrYVy8uBlwKXJ793mNK48jDFJzdCYjLGMbKE4zcl/KpGpzzZhr7Z/Knxyz
 EmldCYXAKsmgQHguwPc25J/EY2rJQ1XXcAi+IB3VE0w6pTZ5W/v8439qvw9Al/4n2UDUTGNc5jE
 KFH9m+HuxeR/uBGl2b0qWoIWMlH25KqFE0quoXyiZnCtA7dQo6ZEBrh0P0C6kvOEdCyrys+C4Wj
 1P3gF2LHWhz7ygk6XEQPA7c=
X-Received: by 2002:a05:6102:83da:10b0:5f7:24d8:537c with SMTP id
 ada2fe7eead31-5f724d853admr1622835137.31.1769626766169; Wed, 28 Jan 2026
 10:59:26 -0800 (PST)
MIME-Version: 1.0
References: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
 <20260127181355.98437-4-scott.k.mitch1@gmail.com>
 <20260127105749.2e2059a2@phoenix.local>
 <CAFn2buDn=jUNT2n8dAB0TceoQB5ebkC9nHejg43vDJyfpKMeqQ@mail.gmail.com>
 <20260128093609.71674748@phoenix.local>
In-Reply-To: <20260128093609.71674748@phoenix.local>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Wed, 28 Jan 2026 10:59:15 -0800
X-Gm-Features: AZwV_QhLiiI7RlN3m35_XJAmjyBSS-Cl3vz4WbuZuaw5G9RICCc2FCIEXwEpyx4
Message-ID: <CAFn2buCSeFVi8hVi_fnmpjFKCm+YjsEm0tkC6xVcJS=7pjhgSA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] net/af_packet: software checksum and tx poll
 control
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
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

> Well tap should NOT be doing software GSO and LRO in DPDK.
> The kernel driver has ability to do that, and is better done there.

Agreed if we can propagate context to the other end of the device best
to let it handle it. Some context/constraints:
- current mechanism to propagate context to kernel (virtio_net_hdr)
doesn't support propagating "please do ipv4 checksum for me", and is
done in software for virtio too [1]
- I have a not-yet-submitted patch to add virtio_net_hdr support to
af_packet PMD (for TSO/LRO). When enabled, the kernel requires every
packet rx/tx has the virtio_net_hdr header, and I currently made this
opt-in as a vdev arg.

This leaves some options:
1. cksum support independent from virtio_net_hdr (my current approach)
If virtio_net_hdr is enabled and supported - use it. If not, the
software fallback path provides cksum (what is in this patch)
- Pros - cksum is supported regardless of virtio_net_hdr
support/errors, overhead of virtio_net_hdr not required for cksum
- Cons - 2 paths for checksum, more code (even if shared with TAP)

2. cksum support ONLY IF virtio_net_hdr enabled/supported
Pros - Single code path for checksum, L4 cksum "offloaded" (L3 still
done in software)
Cons - must always enable virtio_net_hdr to get cksum/TSO/LRO,
overhead of virtio_net_hdr on each packet

Do you prefer option (2)? fwiw, I didn't observe meaningful overhead
from virtio_net_hdr, and it seems viable.

[1] https://github.com/DPDK/dpdk/blob/v25.11/lib/vhost/virtio_net.c#L690-L697
