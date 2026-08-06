Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC8FC56205
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:01:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DD7A4027E;
	Thu,  6 Aug 2026 19:01:18 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id E907C40262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:01:16 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-ca7c1176317so2174968a12.1
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786035676;
 x=1786640476; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l8FvXdnP1AoJ8Np0sYevLP5wODfjwlWQlBM+baS17h0=;
 b=rlJpK+wJghA3sf6PeY/zgF+qBtJ/ppBlV66J0rYk5ZbhgHh3GmBvvhdO0Lq6SX2qYx
 vhYeEa9p4ir22d64YjPIFM2od24/2HIiulOl0aB7LLUfQsBiiTNzfUgTJRNsOXFsvkA3
 x1LwRcDZS6+GZuSk+eZbE642RHhPBEI30Io3TXRPJ+ydFH82u8DhJKFayIPaMe0wPAwR
 JLdlyFThjTv9ASHVxin4AO8W513xD9t9Z3zUh/U0sltHq7R9JwphSdZ5fEO+bCUKyNlX
 yHWVfbH7hmpF88TyQtIE/sWAHU1i9sKPrTGitaCJW8INoNmYc20rJ5s3GcPWbl7lC6nr
 sfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786035676; x=1786640476;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l8FvXdnP1AoJ8Np0sYevLP5wODfjwlWQlBM+baS17h0=;
 b=U0FoGZ78IlU2Cx27P7EaVW4RZfDTg/vuGN7wU/N5pDvG/84jBRLMJmzxkqByeu7hv3
 /bVUdvDGL8A85tA32wuK0gVBImqngb67vx0nvsqVyAShK7adf+2koZnimunjUlL4gcQ8
 +4Jex+jTJkUgJRPPdkPXSdlALqT4yfG3Z0JaxbfoZeccbXEwXbj3wx6r9P7+xy6MVLQz
 hR6yd6hfQFpAAYGEsbCopTSpiDnK2ysiat1qCCCpobZHvq+LEHue1D9XfRGqGCEwyN8B
 GuN5BT5Zdxzlw0IrTP4EVUKMdWABAyh/xSoAK/KPViDfIC5O3PPLIvqk5NmpmfuKFGc8
 WjRw==
X-Gm-Message-State: AOJu0Yx3W13qSjNkoQIWKF4D8hTP3981lYgzjBfUpVXnJ7SxL+LeOi8w
 mfD81RHQrC1/VpaX8LpVFP5VEpNqnhWDrHlieILbVFNH5mVH/gpko+VGIutZSo8R/L4=
X-Gm-Gg: AR+sD12OxADyxn/oHXBfRlvgEGQObncZIlK7JD9LD4ac5YCMQkqjgEE+lToeRH/M/kf
 oSbvHq2LQFqvszUEVLO0zDnmvRlLLoxz6jzUJxVOcU/BcFcAsJ49d/WAvt+07LkWG4eybzpBU+Z
 X8jM2UBDAZIwdfVpQmpj0gOW+rnr4Kx17qG6tPf6g7uBmct3wNPfFd5vwnPLjrEbtLhnaNV6UKu
 AbcXSZ0MbRBjXgK9vIDAqiqtZSx6omSf8sE1raxn3XKLWoibF3e1lq9fA4HzXRYo2FUmy+fNm4e
 WnCOF7usi83VMgW8N4+F42weexC3k7+qXnYYLdu8aq7jy4fIKzECT49vbehr3zECRyJaIoNtA99
 qjnSvdEbjBLVMECHpMWVS9DBREEX6Lv/fpQdkDtRf2SPP23KrZ5T04smhklmoxgvuVrxeI5MhUO
 wjNFrcTEnmzGyElw745VpYFQlURyLiyVgE62ZmGnZm1MfY22dy2EsQGVyg5XuTmGW3LEmRygo2j
 7xzdi6SYJVsDXZ4/11ogey9Q9dLQA==
X-Received: by 2002:a05:6a21:4685:b0:3c4:3321:4fe8 with SMTP id
 adf61e73a8af0-3cb85dbd1ffmr20412582637.14.1786035675736; 
 Thu, 06 Aug 2026 10:01:15 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0bfesm30152979eec.3.2026.08.06.10.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:01:09 -0700 (PDT)
Date: Thu, 6 Aug 2026 10:00:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH 00/14] net/enetc: add new features for ENETC4 VF on i.MX95
Message-ID: <20260806100059.0540c2b6@phoenix.local>
In-Reply-To: <20260806112836.707921-1-g.singh@nxp.com>
References: <20260806112836.707921-1-g.singh@nxp.com>
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

On Thu,  6 Aug 2026 16:58:22 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> This series adds new PMD features to the ENETC4 driver targeting the
> NXP i.MX95 NETC IP.
> 
> The series covers:
> 
>  - KEEP_CRC Rx offload: preserve the Ethernet FCS in the receive buffer.
>  - TSO: TCP Segmentation Offload for the VF Tx path.
>  - RSC/LRO: hardware Receive Segment Coalesce for PF and VF Rx paths.
>  - Link speed code: extend the PF-to-VF mailbox field from 4-bit to
>    8-bit to support speeds beyond 10G.
>  - Firmware version: report the NETC IP version via fw_version_get.
>  - Register dump: dump SI, port (PF) and BD ring registers.
>  - Ring parameters: implement rxq_info_get / txq_info_get for the VF.
>  - Link-up interrupt: refresh the cached link speed on each VF link-up
>    interrupt so that link_update returns the current speed immediately.
>  - Stats reset: software snapshot/delta approach for VF counter reset.
>  - Per-queue Rx interrupt: MSI-X per-queue Rx interrupts for the VF,
>    enabling interrupt-driven receive with l3fwd-power.
>  - SI VLAN: hardware port VLAN insertion/removal for PF and VF.
>  - VF link status bitmask: switch VF link status to bitmask encoding
>    to align with the PF and newer kernel driver conventions.
>  - TX PAUSE: VF sets Rx congestion mode when the PF signals TX PAUSE
>    negotiated on the wire; adds Flow control = Y to enetc4.ini.
>  - WRR Tx scheduler: per-ring WRR weights via enetc4_txq_wrr devarg.
> 
> Gagandeep Singh (14):
>   net/enetc: add KEEP_CRC offload support for ENETC4
>   net/enetc: add TSO support for ENETC4 VF
>   net/enetc: add RSC (hardware LRO) support for ENETC4
>   net/enetc: extend link speed code field to 8-bit for PF-to-VF message
>   net/enetc: support firmware version get for VF
>   net/enetc: support registers dump
>   net/enetc: support ethtool ring parameters
>   net/enetc: refresh link speed on VF link-up interrupt
>   net/enetc: support stats reset for VF
>   net/enetc4: add per-queue Rx interrupt support for VF
>   net/enetc4: add SI-based port VLAN insertion and removal
>   net/enetc4: update VF link status to bitmask encoding
>   net/enetc4: enable TX PAUSE via VF RX congestion mode
>   net/enetc4: add WRR Tx scheduler devarg for VF rings
> 
>  doc/guides/nics/enetc4.rst             |  81 ++-
>  doc/guides/nics/features/enetc4.ini    |   8 +
>  doc/guides/rel_notes/release_26_11.rst |  19 +
>  drivers/net/enetc/base/enetc4_hw.h     | 129 +++-
>  drivers/net/enetc/base/enetc_hw.h      |   6 +
>  drivers/net/enetc/enetc.h              | 135 ++++-
>  drivers/net/enetc/enetc4_ethdev.c      | 394 ++++++++++++-
>  drivers/net/enetc/enetc4_vf.c          | 780 ++++++++++++++++++++++---
>  drivers/net/enetc/enetc_rxtx.c         | 531 ++++++++++++++++-
>  9 files changed, 1950 insertions(+), 133 deletions(-)

Lots of build errors, please send your patches based off main branch
and do local build tests (ideally with gcc, clang) before sending.
