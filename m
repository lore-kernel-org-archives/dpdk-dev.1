Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27DCCA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 19:49:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C935D40292;
	Wed, 20 Aug 2025 21:49:58 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 38DF54026C
 for <dev@dpdk.org>; Wed, 20 Aug 2025 21:49:57 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3bb2fb3a436so134032f8f.1
 for <dev@dpdk.org>; Wed, 20 Aug 2025 12:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755719397;
 x=1756324197; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sq3FwQYO8+aDP1EoZai0sYw1dHiAkkIBq+hgiLf3JJg=;
 b=ZuhChT5sWanTeeX+cHsTdyPDrmnBORasB9HT8atNsfs3jB0/xX3t72G0od9pfXeAU/
 VZvqSnFVkAM+QEB+r6sj3iFXFWQj/98zMuNLJ70W1xK9mwYdTtMvJMz7liN1/9NHdtZ0
 Bk3fy2h4A5PM562OsaD/tR0CN6wLf3vm3bqILdSYpWwWhDr9Vco1JXLy4E00z1+OaUr6
 THYRZkWPZzaRobqSv1o3dqUsKptEYvhQyR7wlCVg/NqGjrvPj9JVlPgnvGrr+b+LrXAV
 KyKLNJ9iF8qF7gU81+Nl1A2USW5jQ8xevGmjSBZ+/DudiEbosJZmHIviPHTYKN30iiOZ
 wkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755719397; x=1756324197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sq3FwQYO8+aDP1EoZai0sYw1dHiAkkIBq+hgiLf3JJg=;
 b=dE/+b6eyHBt1am1HyoHrv/JCbYb4i0zS3mNT4oo4rbnWX6AHFIxycCW4z0hz2BZIV1
 NJNgzamDZuPusEGB1vA2vokZATMslXhx2zZq1np8P2lAbGPVR3wb38rGeh2VvaOLyVdV
 0JdcmU/IauxlVz/wzBzPOn2VlvClKeAm93v80OOWekJZOYlKOiPAcly5ZILZG+FuFytx
 6xoxCxSzztPSREm8GDJ/SjZx7ynWtJC4BTXqtQ4JopJdtjMZUhVCtwLsSxOCOaJMZDdA
 idd0YVdRWXJuc28wbJPQP/3v3Pru5SV+4bzjz4FS5kqU75mA7tBBcAInPOs5+hCmN1bL
 Jecg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAxySqC3YqQbmZC9tmZ/eH/8M2BeFeWTyvfoe7rH3ghV95PYqqUgS+4MDdI8Zlr/hsg7g=@dpdk.org
X-Gm-Message-State: AOJu0YwL95xtoFHMjNo+zkEUvc8voiHdZsdLuc6IzvishWwr7qeneXFJ
 KiafGrU5XSYqzCBvxV5AoHdUBz8AoVPonvcAZqJg/lR+xb5QhJq1zBbIrPg3iM41RmE=
X-Gm-Gg: ASbGnctt9fP6OTdvm4ATHN7vr/hdCt84T9jgRlZyagiNm0m7i7CT+NiMT+doX0w4IKi
 /X2YHGoHHFS+P0AwRGW7YfeTTgwL4pWWIBa1GH4/yYioGlMXoeCIS9MIUSdnJ/fZdwCOrYZnars
 b7C0tPvGWufjZ+ccPgLWY8EYDQZs0Ha8B57mbefIyN0N491+EzZ11bBlXGGX2L4rae6b/4ebByn
 1PCbovWVGEwE3ZKetqWJj/mpw7dXJ+bZNxVYRb0DzuCek9ifsJUNO3ccnKoc4SCqeO41AfmG7n7
 TxUL8bSY8OBb5KBU0aznSlU9eRE2Z0te8KAn4oDyEKR8DDRrgs/4xlDXfBFuIaki6Ip9uzpmE/J
 gpFGxaCv50EqqUBYXSTYbnG6HmKHYDZiRfgMCwu4lYbLOmR2H38iMlMumwvKgMNi/mSD5FBCTTn
 lrvfC9Pzhuvg==
X-Google-Smtp-Source: AGHT+IGX+/skHTtPWRfmqzozoTW6htYEKmI5Kdx5cAbpnef7IwbVBw/QZ5g/4uTTtsbhztI6E/EJwg==
X-Received: by 2002:a05:6000:420a:b0:3b7:9564:29c3 with SMTP id
 ffacd0b85a97d-3c4972748afmr27652f8f.49.1755719396736; 
 Wed, 20 Aug 2025 12:49:56 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c0771c1708sm9049570f8f.38.2025.08.20.12.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 12:49:56 -0700 (PDT)
Date: Wed, 20 Aug 2025 12:49:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linuxonhyperv.com
Cc: Wei Hu <weh@microsoft.com>, dev@dpdk.org, Long Li <longli@microsoft.com>
Subject: Re: [PATCH v2] bus/vmbus: add device argument to configure if NUMA
 information on the device should be ignored
Message-ID: <20250820124952.7cd930cb@hermes.local>
In-Reply-To: <1755563066-2592-1-git-send-email-longli@linuxonhyperv.com>
References: <1755563066-2592-1-git-send-email-longli@linuxonhyperv.com>
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

On Mon, 18 Aug 2025 17:24:26 -0700
longli@linuxonhyperv.com wrote:

> From: Long Li <longli@microsoft.com>
> 
> In most cases, netvsc is used with a VF device. The application generally
> runs with better performance when all the device memory is allocated on
> VF's NUMA node, as the VF device carries most of the data packets.
> 
> But sometimes netvsc may run on a different NUMA node than that of the VF.
> This patch adds a device argument "numa" to allow the application to
> configure if this vmbus device (netvsc) should be NUMA aware. The default
> behavior is NUMA aware. Setting "numa=0" specifies this vmbus device is
> not NUMA aware.
> 
> The device argument is parsed at the time of vmbus device probe to ensure
> all the following memory allocations are done on the configured NUMA node.
> 
> Signed-off-by: Long Li <longli@microsoft.com>

Putting all the args in vmbus seems confusing, and not what I meant.
Was more thing that ethdev and queues should be on same NUMA node.

If NUMA is better why wouldn't it always be on?
Since netvsc is really a virtual device not sure.
I suspect 99% of users will be using with VF, that should be the default.
