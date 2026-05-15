Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CD7CD343F
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 23:19:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C7DC4026C;
	Sat, 16 May 2026 01:19:08 +0200 (CEST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50]) by mails.dpdk.org (Postfix) with ESMTP id 8ABC040269
 for <dev@dpdk.org>; Sat, 16 May 2026 01:19:06 +0200 (CEST)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-bd5126a5e0fso52628366b.3
 for <dev@dpdk.org>; Fri, 15 May 2026 16:19:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778887146; cv=none;
 d=google.com; s=arc-20240605;
 b=MzpEyxjqHpEWBcgq7IkPfOgrDd8l9yu7IFEWhuOstRf4qQWX6vhE+BI8Bolde9OMD1
 81aHaPhLPbWjLxUAGVcAn4vHWhmUoLqQSsopHfL7Q2flF2H61h4sRXrUwke0Z3h/cshs
 qE+vkqbCoBXTZffDFt/cW0nyBDxsxhJb7abXLI06f7tFgvcUgsLGCuOTVdHmF+Tm1Jaj
 W0ggRMFKXG2EdKAyuy9kTrRs9sEOlRHhgw6KO03YgDvgxdEl5mdI6k+1qEkHCsVFSIGy
 yKPVWtYgaBT0xgMwLLcHTMG2J5AXjFYD6UH9MzL8P3iM7a6IcdBD9Ra+63GoRazD5yZJ
 Y6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rs2BUeCD5KFYWViOeuuoWI5GLk0szIZU4LIqlJhjkqM=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=W4tg4qxykefWAz4WiKXQolysW3z+ZEJn38qH6/LWkAgpCAzhGgU41bcCNz5NGAvuwD
 6H2fZsm6UfPZKnti/aeWJ+YkrztBjlxViAij5S1TODO5r0Utg/9xTEcVYnz9qQaJTJRh
 ffB05iZsYWSjc1a5X5z93VuiN/RgK5qFTvVTvVwUQx2GDRR4qQzp4zJm23Ui/WKQcg+a
 SRU1fxfoqzL1fQtaXYRQlC6QSCwta001LnoNCydCqC9Bnp/sSwXlgYaU0mJhWKadLOC2
 fQQgiiNYROSiVu/MnK3XzTP5/mq52aTOxX3N/F1/SYqD0zqY/1P8AkcuT87yOf13mSN4
 p+eA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778887146; x=1779491946; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rs2BUeCD5KFYWViOeuuoWI5GLk0szIZU4LIqlJhjkqM=;
 b=E38dv3BNHbYFGYx4fynd8r1VuUvhmbdgRdPEDmJfwfabZkNg0aqOubF4Od6IaDHXZ8
 mqhY+cLIe2Ju64PyHVhxgDOrdMXRYinjuKsS40l5EVz7ml74Jz93QZg5l7+a7jh3/QF3
 WpitcvHSuaOLztFnq2SCSnMy/EbP5ONGH1vBaNiG0kmdp7xEHkUdcTVAaWilfWYDh1Uc
 zQ4rDYeltikrGHg3eB1mEGgRKJmEm7gqITZPUIHb40ChXvJxdv1RWocfT1Upsadcb8S1
 Uc5szLhhJVXfcx6nN3lZYvL1LNrykEgvN+zLu/t8ncNDaN48oZw+RsNt3YRF105rH6fK
 3CMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778887146; x=1779491946;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rs2BUeCD5KFYWViOeuuoWI5GLk0szIZU4LIqlJhjkqM=;
 b=Xw+cryoFkAi/KXs4EIJ9VeispUFduvZBhqnd/ayl7+Cmdy97W/ucMcSlRVQEbB5vgN
 kFxGk5FhudFo8RRZW3R65xjTPisJHjklm8MyNoelHlNucxTBYETNm+NtWBPIh05VgfKZ
 pHpy5rb9Oxb2P9+3bfr5wxgMXmI92P2F4Nb14loF99yNRCai9e2KvGzTBEnn6ZWDIBzW
 evL6EplqQRpuO6Oj2aZ5IoJzejYEhpwbqrxCQIwL4cQxb9zDwKWnno/pmVGvTy1vsYlc
 3KoCZcszp1fzZFnuF6BuP4hUsW8jSZYL7yC/oyV9fLlXVaWiG6Zt6J34hAbXntwCU3Es
 ihCg==
X-Gm-Message-State: AOJu0YxcyIE9mvmy3DZm7kOtgqTnoRPiXT16udj04w5XR1IERsBU7N/w
 JlOlXn/tH8380fJTXB9aHLiO08LIFf9LT0ZnJAE+bg+0idl9JhHxRKDosD6XC5qyYJbqXp6TQWd
 c6Py2K9rF0lEvTKnHT2R+fyIBboFJCjZ6tx8qHv5AbzdY3H+/bBf+j8LtUbo=
X-Gm-Gg: Acq92OFbJG8LNFrfuJMheLuvNnrsqnTSfxIx4tVHmHwfweMzMm9h4/+Dn0JAfONqhU+
 FNlGVIOGmWLo0a8r7aMSySN3ee+67arR34As33vW2R2i3xSaU+2WPqTTvt/ivTU//8GeCX481XO
 z75hP/Ih8ZrYIMdS9dIdltUFg/KrnQmYOEWDAIh9dsmBgKJ+aNV62CN2D/ueuGoRDfy2fCdB/ac
 kGbnd1b2kUuSSp3md8rIUcvN/IUyi/jrKT5/dxjEfv41MIWqOnUmCpsAVfq42s1jOTP8gaEZE3W
 Y/9mtLt7Oq+niA1DVx+HRh9QCi/5a4wHppeADmBRbgLfzJ1/dCfM2GQ63vrHWyiYBrfwU2Pnf96
 cWHdT/89pcrG0S9rOD75fpgDZhdGLf/E=
X-Received: by 2002:a17:907:960d:b0:bd3:2385:ee0b with SMTP id
 a640c23a62f3a-bd5177d4699mr338079566b.9.1778887145467; Fri, 15 May 2026
 16:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260512005404.946979-1-blasko@google.com>
 <20260513164114.25de780b@stephen-xps.local>
In-Reply-To: <20260513164114.25de780b@stephen-xps.local>
From: Mark Blasko <blasko@google.com>
Date: Fri, 15 May 2026 16:18:53 -0700
X-Gm-Features: AVHnY4ITcWLV0A-CemDOARCCKSiwskFPEGBRuJfId0zyoGaPH28J6qJ-ru3EwKI
Message-ID: <CANULgnKecfnVn+jaZcuHeJZMrGSHSJWmL=UR+JY_MdFv-Vhe+Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] net/gve: add hardware timestamping support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Thanks for the review, and apologies for the accidental spam
with v1! We'll address most of the initial comments exactly as
suggested in v2, but have a few follow-ups:

> [PATCH 4/6] net/gve: add periodic NIC clock synchronization
>
> gve_setup_nic_timestamp() discards the gve_alloc_nic_ts_report() error.
> If the memzone allocation fails, priv->nic_timestamp_supported (set in
> 2/6) remains true, so dev_info_get() in 6/6 will advertise
> RTE_ETH_RX_OFFLOAD_TIMESTAMP and read_clock() in 5/6 will return -EIO
> on every call. Clear priv->nic_timestamp_supported on alloc failure so
> the capability is advertised honestly.

To avoid dishonest capability advertisements and -EIO loops while
preserving hardware capability tracking, we plan to leave
priv->nic_timestamp_supported untouched (as it represents immutable
hardware state). Instead, in v2 we'll predicate capability
advertisement in gve_dev_info_get() directly on memzone allocation
(priv->nic_ts_report_mz) and add an explicit error log advising a
device reset for transient recovery.

On Wed, May 13, 2026 at 7:41=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
> Patch 5: net/gve: support read clock ethdev op
>
> Warning: gve_read_clock and the periodic alarm callback
> gve_read_nic_clock share a single DMA buffer (priv->nic_ts_report)
> for the GVE_ADMINQ_REPORT_NIC_TIMESTAMP response. The adminq_lock
> introduced in patch 1 serializes the adminq command exchange, but
> is released inside gve_adminq_execute_cmd before either caller
> reads the buffer:
>
>     err =3D gve_adminq_report_nic_timestamp(priv,
>                                 priv->nic_ts_report_mz->iova);
>     /* lock has already been released here */
>     if (err !=3D 0)
>         return err;
>     ts =3D be64_to_cpu(priv->nic_ts_report->nic_timestamp);
>
> If the user thread (gve_read_clock) is preempted between returning
> from gve_adminq_report_nic_timestamp and the be64_to_cpu read, the
> alarm callback can run, memset() the buffer to zero, take the
> adminq lock, issue its own command, and either leave its own
> response in the buffer or be mid-DMA when the user thread reads.
> The user thread will then read zero or a different command's
> response.
>
> The simplest fix is to return the cached
> priv->last_read_nic_timestamp from gve_read_clock rather than
> issuing a fresh adminq command. The periodic sync runs every
> 250ms, so the cached value is recent; the .read_clock semantics
> do not require a brand new device read. Alternatively, use a
> separate per-caller DMA buffer or extend the critical section
> to cover the buffer read.

Before returning the cached timestamp as suggested, we wanted to
clarify the API contract:
- Is the fact that .read_clock does not require a fresh device read
  documented in the DPDK specification, or is this based on typical
  application use cases? If the latter, what are those typical use
  cases?
