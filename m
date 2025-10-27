Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906A7CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 16:06:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA35A4028E;
	Mon, 27 Oct 2025 17:06:46 +0100 (CET)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 86CC94028B
 for <dev@dpdk.org>; Mon, 27 Oct 2025 17:06:45 +0100 (CET)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-78af3fe5b17so3606411b3a.2
 for <dev@dpdk.org>; Mon, 27 Oct 2025 09:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761581204;
 x=1762186004; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E/7hHDF8TaeqHp8F+GtAq/iePhThU28q8Foo4CB7Fuw=;
 b=cldHh485X1c1WZ/sLGvxvJD7Rx4shLGF9gBgy/UFLkjazZW92iI4F6VvB7wApj1v2O
 ef7IPSwjM7LZl/Nu0B6xWAbGHcoLLq2iGROVgDsWzoJH+V6rKMgMEGIhjHG+ADd6c8GL
 4/7E6AHctJfww+QdoZRWbEV1foelJFILCl3SArH7arPAMg6eEyW/Aho88VAVrfnRwUxW
 uW/giwIML3C2tOqsAGkSHh+M1WZbxBrUnfM51Enem3IyGTxeSjY4yOTF1bBOcobBujK0
 TmPRiobT5+RqFsNlWr3DgMNQ+KWi3emZAtTYxA/RsMvB9pbEDpHmaHsctctHJ7zxy0Ag
 Gqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761581204; x=1762186004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E/7hHDF8TaeqHp8F+GtAq/iePhThU28q8Foo4CB7Fuw=;
 b=cZKyEHdgE27fJrHONDj4gimCqBb/shJi/yG45w0tFzHUOkTXPdr+A22qK96kujXC1p
 J18cjXa4+ZoYUkyamp6ijEANXd0F2CrvmESQvgN37fXdcjrZ6KaX4fZjiy+bQO5d4n6D
 KDX6JU4rZIT342PAkT6+StKS66MrlwBk9/XIYp1qUQmhJIwUT/qcC4QFlACrC3BHSLhR
 avzPM+wqIo768dSlaPPTezvL5WJHDUPHgQszsnS6SDxFy3EFSbfQTvw6zOd/V6zjkM3n
 fE6dg8R7Cv3hHn7Yngn9QNlOh8OCBHnaLydwsHCO4RtqoiN+BybyqH8VEcRVOzUrrbvf
 uUvQ==
X-Gm-Message-State: AOJu0YzT88R7011NJPeYUCgHAJq5sP2AhqN0op5cuJXu3i1RosC1Zlzy
 abZsRcb12rzQZLPpqZS+hIFlE/CGtxWkUeR6HmuaVjYtGDn3FVlKWLsEiBnYk0zR5G0=
X-Gm-Gg: ASbGncsgAXNXN8c2tq9rGyZKSsOhW+HLNCiiicDLNbcS9XftwE6jW4LQ9MgXRv2Ew16
 awOeNJA7NM/01fTgfRKx1dSsgXQDv7Alaav7WpmR8M4jAvZfJGs7Ic0WE81TOv8GeF2xFHziV6D
 MF94tFuTNF25In9B9c30E6uhcgXCZ5vI3eDMIhDJDKDX2z+BUtIBpNi0woALafALPAqXjkRdrO4
 D4IS4GZLppo5LSqBn67+Pi9Er/WRiaA54ph+v4s9fKXQQNMpHsYeu+9IDChVYZs+f8Y2XDLfkt3
 j2vrT34hp0XMIsYEnRvhGYvB9QhBnaOMXgJAsT8IsPBQC14w3TBorTxCTaTK8ckCvQbUDsLKLHI
 LJqB/FqBZz8mCZKtMDae5zHwDNC/Bfli2pypaWR3rWNUhF9USfph6T3QfpMjRbdxmV04PERF0Zn
 6aoyNluAnCke53S6q8EUHX4jYIizHnOLSqrg==
X-Google-Smtp-Source: AGHT+IH9cwBXxf+nqTu5kTMs8hH3RsOMRYdHttSTdER43Tm8oY9mhyOqyI29naK/bj7pq+4QCpVLKw==
X-Received: by 2002:a05:6a20:2445:b0:334:adbe:752a with SMTP id
 adf61e73a8af0-344d3e45e5fmr187245637.31.1761581204357; 
 Mon, 27 Oct 2025 09:06:44 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a440a73638sm763619b3a.5.2025.10.27.09.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 09:06:44 -0700 (PDT)
Date: Mon, 27 Oct 2025 09:06:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH dpdk 3/4] net/tap: use netlink if possible
Message-ID: <20251027090642.13524bf2@phoenix>
In-Reply-To: <20251027153750.445275-9-rjarry@redhat.com>
References: <20251027153750.445275-6-rjarry@redhat.com>
 <20251027153750.445275-9-rjarry@redhat.com>
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

On Mon, 27 Oct 2025 16:37:54 +0100
Robin Jarry <rjarry@redhat.com> wrote:

> Make netlink socket available unconditionally, not just for rte_flow.
> 
> Use netlink for get/set operations on link flags, MAC, and MTU when
> available. Fall back to ioctl if netlink socket creation fails.
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>

Netlink has been available since linux 2.4!
Rather than having two code paths, only one of which gets tested,
better to commit to netlink and use it.

Since dealing with netlink is a nuisance, I wonder if using
libmnl would be better. Yes, it creates new dependency but netlink
handling has been place with lots of Coverity overruns etc.
