Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56123109448B
	for <dpdk-dev@archiver.kernel.org>; Sat, 21 Mar 2026 17:06:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80E5E402DB;
	Sat, 21 Mar 2026 18:06:29 +0100 (CET)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 24B2B402C9
 for <dev@dpdk.org>; Sat, 21 Mar 2026 18:06:28 +0100 (CET)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2c0ea57fea7so3366179eec.0
 for <dev@dpdk.org>; Sat, 21 Mar 2026 10:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774112787;
 x=1774717587; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OY26Z3pAbWSfOXpddCufyOFsf6NVG6/7MIW7i9q7tUk=;
 b=D6qWaeK5GmC7cdHfRulWhF0GHLz1tijzO2RiInF+MmHaeDQqAD1QU33+SE7bbHHVXy
 UOOTIsme/z28MS/fhmRn0jOiw8aLU3JjAlylLsMQf1SprKlUktq61+v4B8VJarFsd0Gu
 iFMUpkejiPMQoeBMqNkq3zSymdy3X6XYhWaqpyupPEfeXFKLIFHnb5JmAESm9eDKqKk5
 EBNsas4rIH4H6jxVWLb1i5ZH9Oy//YvFH+7/4J2P5qvXBosj/tO5eepD9RDhGdB1LGsu
 Srds3yvtH7hZyyDWb1kWn4XneWmQCIuIdiB/YHNm4w93AyNNeKB8s34I4FjcUTi31O5J
 sEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774112787; x=1774717587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OY26Z3pAbWSfOXpddCufyOFsf6NVG6/7MIW7i9q7tUk=;
 b=RkaxaV8VIkBujCgJ7cvNmdH+ELE9HsT3j4SznMALQRm43OlhYGa/iyYYSVe3HyDY4E
 sLFIvXGtY6amUBHps3Km/AWGCtF0m8bWRhEAAraBh5ifcDkK/qnV2stafjHZbln4l9AX
 MT7GqdwGk5fU6OfztwN/29Fh68jC4eg2+eys/HMv5qWPt9nGA7PzuWc6xkoSYhnm5UX4
 pFMJ+7aZT9VR5/SsNRWL+XbErk4OoMqeEniLXWLuPxNlkcg7+VVW/rsY8r2XsBVGcveC
 3/CPVscPgNltp+GdoJNYAleuQFzCVXEaXRkT+YF91pnEV1Sze4qD4e+O9wViLSpEStAZ
 vfPw==
X-Gm-Message-State: AOJu0Yw5jeLAtdyoMxKZ2YiV2+dmr1EKrA6KQ7FK/1bAezcmXlZHySrD
 hzSNyYN6hd9SfvoOFOrGFJfILPN3ZBTlCvEi6gCPLykXRtuZIOTxbJGS5l1ZGE8BTrs=
X-Gm-Gg: ATEYQzw5UbONNcXR6HkudRrO8CEz6Y+mrjXy8iru67a0k8RMfTBNa3jAF136ByFa0If
 elJHNBMfiSqYAr/UEISXXDqpByfCiCcnQ/ZUnpbHWq9e+CRfDgDTVjtSlyBK0Pq4zm8i2G+ZnTy
 gRwdyNjQaC66UiGHJXpjx+01sOQiQMth8h/QdO+do2CXW8R+TP3Eq+w3y1kl3sqSGg+n8DqPDoJ
 ukDSu4hvaSYmZwz02e0J9uYE3iP+VJXhilJgGSbnG8JwkK3pFU3BpiBrvcdq3Jo/C7Bg8BFRmUw
 McECpJFkJCzGeh8nGu7BI6FdF2y3KEQdxWcgY4oE6aqa0wp4KJHA3aJrc5p2C6VBOHmHXa+PskC
 GP86UhMyEnxM727YA6w46um2LWbdWNlcvlWhl0QyoMhnupxDlIZSo7922URsygvVjd8VKf0xdGk
 De02O0luFEvdvskcbPwnAIueVYYk0JfzF+Nwo=
X-Received: by 2002:a05:7300:4342:b0:2be:f15:c530 with SMTP id
 5a478bee46e88-2c1097a8d15mr3323982eec.27.1774112786881; 
 Sat, 21 Mar 2026 10:06:26 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b31fd28sm8074962eec.28.2026.03.21.10.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 10:06:26 -0700 (PDT)
Date: Sat, 21 Mar 2026 10:06:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH dpdk v3] net/tap: add software MAC address filtering
Message-ID: <20260321100624.601e64e1@phoenix.local>
In-Reply-To: <20260321144840.863746-2-rjarry@redhat.com>
References: <20260319221034.703656-2-rjarry@redhat.com>
 <20260321144840.863746-2-rjarry@redhat.com>
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

On Sat, 21 Mar 2026 15:48:40 +0100
Robin Jarry <rjarry@redhat.com> wrote:

> Linux TAP devices deliver all packets to userspace regardless of the
> PROMISC/ALLMULTI flags on the interface. When promiscuous mode is
> disabled, drop received packets whose destination MAC does not match
> any configured unicast or multicast address.
> 
> The receive path checks the destination MAC against the device's
> unicast address table (managed by the ethdev layer), the multicast
> address list (stored by the driver since the ethdev layer does not keep
> a copy), and accepts broadcast unconditionally. Promiscuous and
> all-multicast modes bypass the respective checks.
> 
> To support multiple unicast addresses via rte_eth_dev_mac_addr_add(),
> allocate mac_addrs with rte_zmalloc (TAP_MAX_MAC_ADDRS=16) instead of
> pointing into dev_private, and advertise the new limit in dev_infos_get.
> 
> Dropped packets are reported via per-queue xstats
> (rx_q<N>_mac_filter_drops).
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>

Not sure the xstat for mac_filter_drops is needed, since it is what
other devices do as normal operation.

AI review found:

Two issues worth addressing in this patch.
The rte_realloc call in tap_set_mc_addr_list assigns directly back to
pmd->mc_addrs. When realloc fails it returns NULL but leaves the
original allocation intact, so the old pointer is lost and the memory
leaks. Use a temporary variable for the realloc result.

The ops table sets .xstats_reset = tap_stats_reset, but that function
only zeroes the base counters. The new mac_drops xstat is never reset.
Either extend the existing reset or add a dedicated xstats reset
function.
