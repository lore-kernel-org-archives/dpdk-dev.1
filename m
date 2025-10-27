Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DF8CCF9EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 21:56:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 035A94028C;
	Mon, 27 Oct 2025 22:56:01 +0100 (CET)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id 1F25B4021E
 for <dev@dpdk.org>; Mon, 27 Oct 2025 22:55:59 +0100 (CET)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-7a28226dd13so3980854b3a.3
 for <dev@dpdk.org>; Mon, 27 Oct 2025 14:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761602158;
 x=1762206958; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IcHZjo9lrNXB/24LsDUpSNe+Q/pu0T5BKycwYxUy2ro=;
 b=SWOBw+9KyfyM2m407M5NRzArV19EIBheVZQ7XyGLEZQFETNGPlWhBzFeuaW8FBhNQi
 zJVB1j6dX0u32/a5APoQquClWZWpQfnXjVfESAqYd2BXRBQ+il5cp0eWhN7WrDJEYxIv
 uHVhs5JCn03wekUBiSTmO8OJpp4dR8uyrP+QcJINb43qvrHzhB2ROi3Jx2cPFc3mOEvJ
 hoGp8UfJRmtxr+R6gft7eGl2+r/JIUIsyE4+NCA0n2evitXNysce8Fagm5tVBeTLjkQg
 /PNimTLm2LegD9ytFo38QzcXHUwxE+l/xJx28EXqKqcaCgDaURlPjs3fgODrYqt7E1zQ
 sZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761602158; x=1762206958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IcHZjo9lrNXB/24LsDUpSNe+Q/pu0T5BKycwYxUy2ro=;
 b=AWSiZAmoqQBRK/HpmHrV4kIZe7PAQcuu7wwQSxf68wSnnBW4bx0DbPwuPq1sBzqHJ5
 OAInr2ZZJ5daiBfsHrXseyJFRpskvn3UaqXFn94M+PyGtwDNuAyhVUOzaZUan7eUTv9s
 Ht0U8XWrj3Ifb0kxPe3HqRA2OQsIbv4mL7hnEixJ0FFsfir7bNt+k2/4LfSbKCVUeKCQ
 hWuuEiYZl54YssKiHm2iqBbQmf6OfGqhU/y+nKb3ixRj5bgTgX1D6hJiQ/gvn+AEyRo7
 ZZyWKguUZmbVetLDAwQtayyMfDzI7RMy/osjyLmXZmaAn6ol5igM5/ySm869uhQlFjMZ
 ebIA==
X-Gm-Message-State: AOJu0Yz7dilbCpdGwNEvRDpP4TQl/mqZ5ReLG1ohhCw7zrxowCB95sRY
 2tH7dPk3nWIizjUGQXrbzifeuLdq97NDRFMlTYOlVP9f3dawmrZaibIvDTF28jpWne09229Qpxm
 D6wE7zMg=
X-Gm-Gg: ASbGnctpVcLFHXxzben3OwN+F4O+gQlcnqDQvL50RbuO1a27VaIFZdVhnJgVRPm2A3O
 C9UOEp46hZ6QuQfIuR8ghwNcf2yhuH2khRRm4oCEOLCv8MMOwZLgOYXF3i5bf0VaMIoZInp5ID/
 rXDuHy4H/w1arIrBrYMblMGTlUvrLC9pG58/0jkCrzmxAFCTmmIwopa1rIoDEM+TFRLMBDN8KbR
 ptKnBOgLotfHtasecKVK2104zXge427RdODl2j7yRrsX8/4WFd1aQisHAn1KnkM1qFLgTuWcGT2
 rFny1xCDgIHLOzkZZ3S8r69BpgBMfmlJfrH7xroB/LMEZZl3gBC41/qoxRBywcQCZuI9jm38ihe
 9aQ1b+zY2bHBtl5ziT3AVtrhOESiTjC9/QylTkZCHKLBLjOq9SQab6WT9uB5cAfXyOY6kkKAswh
 +39QAw6BbNAu+zVCvo8/C+LnTSTiBNwGTbRtGUEBSPZKuk
X-Google-Smtp-Source: AGHT+IFOaIP6yHXfDsjWcMaD0zhi2P6ak5iHd5NZXG5ttgcAuEf9iirkm9qPEe4zir4QSZ14DODaOQ==
X-Received: by 2002:a05:6a00:3982:b0:781:24ec:c8f4 with SMTP id
 d2e1a72fcca58-7a441b8647fmr1335406b3a.3.1761602158007; 
 Mon, 27 Oct 2025 14:55:58 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a414068f7dsm9450028b3a.48.2025.10.27.14.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 14:55:57 -0700 (PDT)
Date: Mon, 27 Oct 2025 14:55:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH dpdk v2 0/3] net/tap: add network namespace support
Message-ID: <20251027145555.18fd3b01@phoenix>
In-Reply-To: <20251027181926.489642-5-rjarry@redhat.com>
References: <20251027153750.445275-6-rjarry@redhat.com>
 <20251027181926.489642-5-rjarry@redhat.com>
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

On Mon, 27 Oct 2025 19:19:27 +0100
Robin Jarry <rjarry@redhat.com> wrote:

> The TAP driver currently uses ioctl operations which are name-based and
> namespace-unaware. When an interface is moved to another namespace, the
> driver loses control and cannot track the device.
> 
> This series migrates to netlink-based interface control using ifindex
> instead of names, making operations namespace-safe. When an interface
> moves to another namespace, the driver detects RTM_DELLINK, queries the
> new namespace using TUNGETDEVNETNS, and recreates netlink sockets in
> that namespace to maintain control.
> 
> The implementation falls back to ioctl when netlink is unavailable,
> preserving compatibility with older kernels.
> 
> Tested by moving TAP interfaces between namespaces while running
> testpmd. All link operations continue to work transparently after
> namespace changes.
> 
> v2: completely removed ioctl-based implementation
> 
> Robin Jarry (3):
>   net/tap: add netlink helpers
>   net/tap: replace ioctl with netlink
>   net/tap: detect namespace change
> 
>  drivers/net/tap/rte_eth_tap.c | 412 +++++++++++++++++++---------------
>  drivers/net/tap/rte_eth_tap.h |   5 +-
>  drivers/net/tap/tap_netlink.c | 291 ++++++++++++++++++++++++
>  drivers/net/tap/tap_netlink.h |  10 +-
>  4 files changed, 534 insertions(+), 184 deletions(-)
> 

Any documentation or release notes?
