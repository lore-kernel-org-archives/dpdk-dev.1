Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221CAC3ABB8
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 14:46:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DB49402A4;
	Mon,  5 May 2025 16:46:15 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 12D9F4025D
 for <dev@dpdk.org>; Mon,  5 May 2025 16:46:13 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id EB6AB2111598; Mon,  5 May 2025 07:46:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EB6AB2111598
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1746456371;
 bh=GT8ca4PlFOsb754C8BOCY17GCXJmYHmABI72pwoy+tA=;
 h=From:To:Cc:Subject:Date:From;
 b=RH4R8wvSopI4dXgCFL+TCchpDZnYdeRuWhtw2Wl3/GFOMUIP6esIs/H06DzPloNpH
 /QcSWpiFVNDJOsCaCYMmzhVjYG3SQ3YBKy6YezUsYPn9z2P12uQconei2RsvDuMaXn
 CCCppnDHf2C1EJecjes2QFidTyA/Jq3I1OZKy00Q=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: 
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH 0/1] unresolved symbol mlx5_geneve_tlv_parser_create
Date: Mon,  5 May 2025 07:45:36 -0700
Message-Id: <1746456337-6278-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
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

When compiling DPDK with mlx5 using clang on Windows with
"debug" buildtype the error below is hit:

net_mlx5_mlx5_flow_dv.c.obj : error LNK2019: unresolved external symbol
    mlx5_geneve_tlv_parser_create referenced in function
    flow_dv_discover_priorities
drivers\rte_net_mlx5-25.dll : fatal error LNK1120: 1 unresolved externals

With a "release" buildtype the error is not seen, which explains why this
issue was not reported earlier.

The same problem will show up with MSVC, but patches which are still under
review are needed for this to be hit with MSVC.

The cause of this problem seems to be that mlx5_flow_geneve.c is only
compiled on Linux. This patch fixes the issue by compiling the file on all
operating systems. It also sorts the file names in meson.build in
alphabetical order.


REPRO STEPS (On Windows)

set DEVX_INC_PATH=V:\soft\MLNX_WinOF2_DevX_SDK\inc
set DEVX_LIB_PATH=V:\soft\MLNX_WinOF2_DevX_SDK\lib
set CFLAGS=-I"%DEVX_INC_PATH%"
set LDFLAGS=-Wl,-LIBPATH:"%DEVX_LIB_PATH%"
set CC=clang
meson setup -Dexamples=helloworld build --buildtype debug
ninja -C build


Andre Muezerie (1):
  net/mlx5: unresolved symbol mlx5_geneve_tlv_parser_create

 drivers/net/mlx5/meson.build | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--
2.49.0.vfs.0.0

