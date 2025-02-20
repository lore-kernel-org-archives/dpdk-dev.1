Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC9FC021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 21:24:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B54704026D;
	Thu, 20 Feb 2025 22:24:49 +0100 (CET)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id 4330F40263
 for <dev@dpdk.org>; Thu, 20 Feb 2025 22:24:48 +0100 (CET)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-46fcbb96ba9so16882801cf.0
 for <dev@dpdk.org>; Thu, 20 Feb 2025 13:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1740086687; x=1740691487; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nl4kva2MlrNI7T6pNzFuBgWrgMDTO67RjJEuKsNlOnw=;
 b=PIP2C8ULUADhB7U7ThmMp86tJDfkyFZvLgx4HeqZMMZ59cJk3EXzhKDtmmepzv6h7z
 gZqjH9ssNWQc1qsSzj2yRBT7jmpdPU6WEDqSDzrwoJScfX8HReI6H3HBpomeoOB2fQjR
 +aUt43s2W6FY3Ui5Ds85ImRFRID32UGrlYtxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740086687; x=1740691487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nl4kva2MlrNI7T6pNzFuBgWrgMDTO67RjJEuKsNlOnw=;
 b=In7vnwWaNy0Q1JMZbmSjskWtX5LS9NbPtsL4IElgjfmZIWWrALgXuP4BlQrUdkIWz1
 HboEtml8GmasR0+lIrIZdTzz1B29t9lXSG0vxKVEWlM///q8D/32GiZxyt7KSX/hofZL
 HjXUmIbHFss9udQgDZJR6Aw08gJWy1qbmAE2yatLFZHok6iWmz4WJjJgREVFB+6mFo06
 PV49zUP4xkf+Vt+nSVnnAOzN9uo5NZycIUZr1NGP04pGelPOlAXP5UEX66tpsmNjMzhF
 ZBYSnbj/bwwJYCEYVfoDAKYfKy4oBh5c5t4ZuEP3P5hBB2oxIRAgiBvHymtKVZqylds/
 HI6A==
X-Gm-Message-State: AOJu0YxoSyAvpi7E3jZP2gYuP4praZNGseFUTvhqbi8FkWzro7/sPAd7
 gLBPyF8UdSBce30IFKnRFtvbPKL0C/hSVDizLIXqT5/j46CZFJi4pKixfZAjBpPV6EgJS2+67DO
 Y0tg=
X-Gm-Gg: ASbGncsLwQp+AL3WSujmSpIj3g1Eh4blW+QH3rO6yIH2iqzGGdDvDZ3Mvsardnzpcwp
 FW8g5gUGDa7+KMKq2CSNcYvKR4LJRLRglVZaZzF91QBlpyjU+4WbJC3keTL+rzc83lcME07oDWi
 d5uUeekuOS9sDmuqRKE00dGMTHzw1EPFiOQlIXL/L5GtMOju0otIsmx0B97jMWBcgZAH/2zSvxf
 pW5GMWm1kB+hF6bap4aETo5QlMBgyLu6LdJOYzUrOHQQ3CBy6v9bU8GmlyB76b9eYa3u2s139rH
 NC4ivlEC/2DzloL3ETDy9OIEWzmkW4SPw7M/vTI6m0Dfiyxk1ds7yJ0=
X-Google-Smtp-Source: AGHT+IGOrhgOlPHrI2vnHaEqbJxU1Z72JOr9XGavF3ad9aInWayXS4PFy5JGrQ2Nt1qLZnZ79LjYsw==
X-Received: by 2002:a05:622a:5ce:b0:471:eca0:1135 with SMTP id
 d75a77b69052e-4722295ca3amr8932671cf.40.1740086687547; 
 Thu, 20 Feb 2025 13:24:47 -0800 (PST)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c0b16072b7sm313030885a.98.2025.02.20.13.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 13:24:47 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, npratte@iol.unh.edu, luca.vizzarro@arm.com,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v4 0/2] dts: add stats checks test suite
Date: Thu, 20 Feb 2025 16:24:41 -0500
Message-ID: <20250220212443.66483-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20240923154936.15952-1-jspewock@iol.unh.edu>
References: <20240923154936.15952-1-jspewock@iol.unh.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

v3:
  * fix name of the first patch

v4:
  * rebase and refactor off next-dts

Dean Marx (2):
  dts: add clearing port stats to testpmd shell
  dts: add port stats checks test suite

 dts/framework/remote_session/testpmd_shell.py |  57 ++++--
 dts/tests/TestSuite_port_stats_checks.py      | 168 ++++++++++++++++++
 2 files changed, 213 insertions(+), 12 deletions(-)
 create mode 100644 dts/tests/TestSuite_port_stats_checks.py

-- 
2.47.0

