Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1E0C5DF67
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Aug 2026 15:43:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6A2040278;
	Sat, 15 Aug 2026 17:43:05 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 0B22840272
 for <dev@dpdk.org>; Sat, 15 Aug 2026 17:43:04 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2caea3f742bso34628955ad.0
 for <dev@dpdk.org>; Sat, 15 Aug 2026 08:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786808583;
 x=1787413383; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Nb6Vz8SFlFR6G+eNlW+Wki1UwwW6+B+KqrLxhvoamcU=;
 b=DOc0jvHRE4F1ENJcGnXtipdvKQHzcx1FLRLnBWQ4hqOJzuvTVXvP4IeiTc9Lw/Qi9a
 CIbVaAoBi0We477gVlkCRuTcFoHg4Dlkvfb5SLwqBvI4zc+6pkYzve1Zcu/YuNogf9c9
 0iHmbnIybu7MohmVFEfTfNYNMYoErbio3Guqh3efPBqXmW4Z54qPAhfyG8mzbLcxqPzM
 LqS2Q6Z5sglf3sWMoML5BOH8MDMk5PckLcOhezT80pO+jF75wJ24M/dOwg360yMRl3xA
 PTp7QABidu/3Byi4xWNJtXodAQgx8Nq+NEfmdvG0JtHc8Byn910gEmXz4uASPl/DI5nR
 OaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786808583; x=1787413383;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nb6Vz8SFlFR6G+eNlW+Wki1UwwW6+B+KqrLxhvoamcU=;
 b=Gu5s+xiZuZjrOeyJDvkQrAdlNGWSF4PSf+SfKCsUwA7OeH/wocu8Wb/FtHsGukvlNk
 NCxRR7/YRas5eRwYqmINu9VBg2wE1U4lcSSY39PJOp8UfryW+zRAbkhThvWhrGxGQ1TP
 Kc1GRlfw7Gt2tklT2P1KjOAol3nfZQufjUJ20yxfo0X2VRpQJAuUjgs5jfWQH7ZZ3hmJ
 jVnVf6ZB8A+JrBBp0nUTHOctATHw18IkIOHdG/d2Vam0cowzi/KejSSfM5ZzRWRZlhrk
 LlqA/hHvh4PGq7Nbo97qZFd3gkuKbke8ffqA5hYuqOeC3YUqpR4Xs+ktvsEKoT+DpV9+
 ipgw==
X-Gm-Message-State: AOJu0YyBIyE5nYdVzrYrM5yr1FddaFKr0q4+O4/ViI+cWr0E0W++CHhP
 u7Z6L65gIM/2H4B6uKM6z1Dj30L4DAegU+nkW3y+6sK1gcDHi5/6HhyN3tQpoDcDvlg=
X-Gm-Gg: AR+sD13kRIkmFwW3YkDhk70O9DpQJ2EMoXyWJryWUdDFoJekmP9PWiF6FGbgRxu0s3Z
 uYtE8jlFDgzCJ7SGZPOtFjQS/VCRMRoCLVH+WgkXN2E6Coge4dv7ysFEvGy9lXUZKqFRW38DiJX
 cil1+OoDaHSIaLzrHrfcES1MZ5SPvzxs1auPcJkyJHR0NgxOLPqYpzVG+XFvYQUc5PpHvVsiJ+9
 dEQ4zEHXmaTA/w42xPuSXUDxF5v5DpSi4NqqvLmL9y5kWGd+NZllFXeHvTv8Z3IViGLAqm7DpM7
 7y3yDt/pzWT0+WZdGcHiEWA3LLJ4ofNC+zjoJmwFPGwH5O/i/n9tGKU/vk2WAX8HfR0oPXhx3aA
 V9D6nIT9AyujO7n08npnXwtHW8T/EVcXJJVGwd68sIVfZl4BcCya+4SQ6qLVgCFh7TW0pzJKuhL
 cS9VL6FqTuDHVBdI4GAyOnYxOlwuUyZhYw5oNmw7VnK9FNdg9FgbtftH6fk0vR0PGNXtBbux1p7
 A3HHPekAEIwMYdYXDq4uTh0HD+uiw==
X-Received: by 2002:a05:6a20:c90b:b0:3b4:6a23:6ba with SMTP id
 adf61e73a8af0-3cc71de3abcmr16257082637.26.1786808583013; 
 Sat, 15 Aug 2026 08:43:03 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141387accdbsm29334418c88.3.2026.08.15.08.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 08:43:02 -0700 (PDT)
Date: Sat, 15 Aug 2026 08:42:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mark Blasko <blasko@google.com>
Cc: dev@dpdk.org, ciara.loftus@intel.com, mtahhan@redhat.com,
 joshwash@google.com, jtranoleary@google.com
Subject: Re: [PATCH v6 0/2] net/af_xdp: add Rx timestamping and read_clock
 support
Message-ID: <20260815084252.30d6e382@phoenix.local>
In-Reply-To: <20260815004553.3479994-1-blasko@google.com>
References: <20260623215325.814776-1-blasko@google.com>
 <20260815004553.3479994-1-blasko@google.com>
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

On Sat, 15 Aug 2026 00:45:50 +0000
Mark Blasko <blasko@google.com> wrote:

> This patch series introduces support for dynamic Rx timestamping and
> clock querying in the AF_XDP Poll Mode Driver.
> 
> The first patch introduces three new vdev devargs to specify
> layout-agnostic metadata offsets and bitmasks for extracting hardware
> Rx timestamps from XDP metadata into the mbuf dynamic timestamp field.
> 
> The second patch implements the read_clock ethdev operation, querying
> ethtool for the interface's PTP Hardware Clock index at start and using
> clock_gettime to query the NIC hardware clock time.
> ---
> v6:
> - Patch 1:
>   - Add per-queue Rx timestamp offload support.
>   - Refine SIOCGHWTSTAMP filter check and preserve flags.
>   - Fix feature matrix ordering in af_xdp.ini.
>   - Add conversion and overlap validation for devargs.
>   - Unify timestamp extraction for ZC and CP paths.
>   - Update documentation formatting, bounds, and casing.
> - Patch 2:
>   - Fix ptp_fd cleanup path in eth_dev_close().
>   - Lower PTP open failure log level to INFO.
> v5:
> - Patch 1:
>   - Fix rx_timestamp_enabled check in eth_rx_queue_setup().
>   - Update af_xdp.rst documentation and code example.
>   - Update release notes for 26.11.
> - Patch 2:
>   - Update release notes for 26.11.
> v4:
> - Patch 1:
>   - Validate rx_timestamp_offset (8 <= offset <= 256) and valid_hint_offset
>     (1 <= offset <= 256) bounds.
>   - Revert parse_integer_arg() to base 10 and add dedicated parse_hex_arg()
>     for validity mask.
>   - Optimize fast-path check and use rte_pktmbuf_mtod_offset() macro.
>   - Preserve config.tx_type in SIOCSHWTSTAMP instead of forcing
>     HWTSTAMP_TX_OFF.
>   - Return -errno on socket failure and replace (caddr_t) cast with
>     (void *).
>   - Advertise RTE_ETH_RX_OFFLOAD_TIMESTAMP conditionally when
>     rx_timestamp_offset >= 0.
>   - Update af_xdp.ini features matrix with Timestamp offload = Y.
>   - Document CAP_NET_ADMIN requirement and persistent HW filter side
>     effect in af_xdp.rst.
> - Patch 2:
>   - Move ptp_fd into pmd_process_private for multi-process safety.
>   - Decouple /dev/ptpX opening from RTE_ETH_RX_OFFLOAD_TIMESTAMP.
>   - Move read_clock documentation out of "Options" into its own section
>     in af_xdp.rst.
>   - Add #ifndef guards around CLOCKFD and FD_TO_CLOCKID macro definitions.
>   - Replace (caddr_t) cast with (void *).
> v3:
> - Patch 1:
>   - Add PMD documentation and release notes entry.
>   - Move dynamic mbuf timestamp field registration to eth_dev_start().
>   - Replace 64-bit pointer casting with memcpy.
>   - Add devargs validation and support auto-base integer parsing.
> - Patch 2:
>   - Add documentation and release notes entry.
>   - Add PTP file descriptor cleanup on device start, stop, and close.
>   - Return -errno on clock_gettime() failure and fix PTP open error logging.
> v2:
> - Patch 1:
>   - Replace static metadata struct assumption with configurable vdev devargs
>     for layout-agnostic timestamp offset extraction and validity verification.
> 
> Mark Blasko (2):
>   net/af_xdp: add af_xdp rx metadata and dynamic timestamping support
>   net/af_xdp: add read_clock support to AF_XDP PMD
> 
>  doc/guides/nics/af_xdp.rst             |  51 ++++
>  doc/guides/nics/features/af_xdp.ini    |   1 +
>  doc/guides/rel_notes/release_26_11.rst |   7 +
>  drivers/net/af_xdp/rte_eth_af_xdp.c    | 340 ++++++++++++++++++++++++-
>  4 files changed, 390 insertions(+), 9 deletions(-)
> 

Reading through the AI review chaff, all I see left as a minor
issue is:

 
Warning 1: eth_af_xdp_enable_hw_timestamping() writes an all-zero
hwtstamp_config when SIOCGHWTSTAMP fails.
 
    struct hwtstamp_config config = {0};
    ...
    ret = ioctl(fd, SIOCGHWTSTAMP, &ifr);
    if (ret == 0) {
            if (config.rx_filter == HWTSTAMP_FILTER_ALL || ...)
                    ...
    }
 
    config.rx_filter = HWTSTAMP_FILTER_ALL;
    ret = ioctl(fd, SIOCSHWTSTAMP, &ifr);
 
The v6 changelog says config.flags is preserved, but that only holds
when the GET succeeded.  Some drivers implement SET without GET; on
those the SET goes out with tx_type = HWTSTAMP_TX_OFF and flags = 0,
which turns off any Tx hardware timestamping another user of that
netdev had configured.  Since the setting is not restored on stop,
that is permanent.  Either fail when the GET fails, or only issue the
SET with a config that was actually read back.
