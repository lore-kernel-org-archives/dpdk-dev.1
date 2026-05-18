Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4887CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 02:22:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CB1A4060F;
	Mon, 18 May 2026 04:22:28 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id E82D140609
 for <dev@dpdk.org>; Mon, 18 May 2026 04:22:27 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-303dbfbec77so578217eec.0
 for <dev@dpdk.org>; Sun, 17 May 2026 19:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779070947;
 x=1779675747; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JsqAakebyxxivsdbIVuK0V//xhkwh/hdtcPlGzFD4Us=;
 b=tjISi9HmK1OJiZLPDsb4NS9O2iO59fW7Hgn9I1+LHTV6Dw0sPjHm0HH0BJVf/7tSLy
 N1ERMdLupxvMjxArYsDBIBUkpn3tcpED10bHzRuISUEXOq9pnZKNIUidrfMUIQtUcOt4
 IRaepWMDh2ISZNQAqVkHaBHJrIX0vTVCWV8neWU8JEgRYv+4Up3jRFjbZSwsA6mB+Xvs
 HifAouav/cQpRuKfBsYPqSfvaCotS4DbmWXfxyazHgx5Zlce5/9EBXpdDy629LVu4u9G
 xmfis9EggSMvKWc0hax4RUEMJX16e5NzJWaHEjhgtsXRk4qUThyTX7b0fgtV6Z2w9Pws
 8mzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779070947; x=1779675747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JsqAakebyxxivsdbIVuK0V//xhkwh/hdtcPlGzFD4Us=;
 b=RjV+kkUdLtLWA9tuBCa76vprB1oWoFH1hgS9nc4lfWnKpomUDSE6O6FmipzCLQVdq+
 86dmVbth0z8kmrWoXEsLB79F75NuNeuZ1o/iUgpcSJwUDm8xvrF/S+C2/x2clfMYuxHm
 gsvryJ7Lw1R6PItpP3Taq7xJ7wW0Pm/LHt70XYzmLpZ8GMN00rHvYjsVBo0sI447ASst
 BjPOXJyMK+fsCR+U3iL6afwiELms9pjp03hpiZE+j4It21N8YwtJiDBXB+GTBPEQcNPO
 17W49lPu5TDXbbqaY0a31YmosYjskTDjPxbxjZ2hDAEQRMA2JPrRbItHRxUFIe0kZfYq
 FoZQ==
X-Gm-Message-State: AOJu0YzURd0RZQRxlXhy/Nu8crXU0wMY0jW2gz3I+iOQ5bo087i/3T5p
 qWoQM2YbjAhMqLT8fglt+Vm3AJdFe2xIADuNywXgdRtBzdYo5KqxhQ0kcBWPAXD2e0U=
X-Gm-Gg: Acq92OHjtv2FyaF3yUkGmJnklMxeaCVCTWX8YCyCZFpjzf1ZMEcbfoEf6hHmMvIAR3W
 9Q4tfvO4kA876X+gxsXapCUfT6vts5WrD8OGKG2Sp0AprY8RILB8Kd9QWzZRE9jvcQpoPATnDF+
 T69/UhZbbtXrRcg48z/MYvdUpxls8hzCRy0EV9Io+4UVcxMNyoBEEueuMvaik+ucSwhAEhnN7hn
 YXqQkFU9fwo73+mgLRjyyPCZQZma5xsmObB853ZMDpt7ySMo9WfnYgN+7+ilycXRyghjTQaXOS+
 fhbVefoRTcCq4XwriJBrOHxbTMAnFbYo2PghbBxA3ue8odI/E0e3YWSdMFlv2cIiXb0EGGAL49M
 FSt12wr7FhAa+aAxwkt10p7b51/DwTpVtNXwC31k7ktJTyOP9RUFVh60HuJOFrJeoSnwPgj82o0
 ywcYqkdL1uwfbQbWMvs754kHhCb4k4xhD/c96AhfBML6e/lg==
X-Received: by 2002:a05:7300:641b:b0:2d9:6373:ad24 with SMTP id
 5a478bee46e88-30398652478mr6027513eec.26.1779070946984; 
 Sun, 17 May 2026 19:22:26 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302978afdd3sm12995294eec.29.2026.05.17.19.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 19:22:26 -0700 (PDT)
Date: Sun, 17 May 2026 19:20:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 1/3] net/zxdh: optimize queue structure to improve
 performance
Message-ID: <20260517192020.20f29d85@phoenix.local>
In-Reply-To: <20260509062930.3254766-2-wang.junlong1@zte.com.cn>
References: <20260423011820.2426203-1-wang.junlong1@zte.com.cn>
 <20260509062930.3254766-1-wang.junlong1@zte.com.cn>
 <20260509062930.3254766-2-wang.junlong1@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Sat,  9 May 2026 14:29:27 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> Reorganize structure fields for better cache locality.
> Remove RX software ring (sw_ring) to reduce memory allocation and
> copy.
>=20
> Signed-off-by: Junlong Wang <wang.junlong1@zte.com.cn>
> ---

Looks good.

Some AI comments:

[PATCH v3 1/3] net/zxdh: optimize queue structure to improve performance

Warning: silent bug fix

This patch quietly fixes a real bug in zxdh_queue_enable_intr(). Upstream h=
as:

static inline void
zxdh_queue_enable_intr(struct zxdh_virtqueue *vq)
{
    if (vq->vq_packed.event_flags_shadow =3D=3D ZXDH_RING_EVENT_FLAGS_DISAB=
LE) {
        vq->vq_packed.event_flags_shadow =3D ZXDH_RING_EVENT_FLAGS_DISABLE;
        vq->vq_packed.ring.driver->desc_event_flags =3D vq->vq_packed.event=
_flags_shadow;
    }
}

The function checks for DISABLE and then sets to DISABLE =E2=80=94 interrup=
ts are never enabled. The patch corrects both occurrences to ENABLE. That f=
ix is not mentioned in the commit message, and it has no Fixes: tag or Cc: =
stable@dpdk.org. Please split it into its own patch ahead of the structure =
reorganization so it can be backported.

The commit message also omits other non-trivial changes: removal of zxdh_mb=
(), and the inlining of zxdh_queue_notify() so it no longer dispatches thro=
ugh ZXDH_VTPCI_OPS()->notify_queue. Worth a sentence each.
