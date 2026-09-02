Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641FDC624D0
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 09:09:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28B5A40374;
	Wed,  2 Sep 2026 11:09:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0B9BF402F0
 for <dev@dpdk.org>; Wed,  2 Sep 2026 11:09:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788340157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JiOCI0IjqU/i7r4txfberGBbA1zOLSyl26/RvDb5QN8=;
 b=VvNwgfGm64Hvc1a9xTh2SuxZetYkoiEWOILaH1FoCFd0vbD1Fr5WZ54AmyiuNhZpL8B2E4
 XMVWJbLULxDhlQfQxDJhL9vsornBr/yEYzGA1nDAZn0RLgyAkr9AAN5SejOQtNtsWErODJ
 CdWaOBbPo4YtkuXtTgnsKwHXIKess/I=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-LcmKz8vqMOGTxBWM6pKVCA-1; Wed, 02 Sept 2026 05:09:16 -0400
X-MC-Unique: LcmKz8vqMOGTxBWM6pKVCA-1
X-Mimecast-MFC-AGG-ID: LcmKz8vqMOGTxBWM6pKVCA_1788340155
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3a1e9f5a36fso4019541fa.3
 for <dev@dpdk.org>; Wed, 02 Sep 2026 02:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788340155; x=1788944955;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JiOCI0IjqU/i7r4txfberGBbA1zOLSyl26/RvDb5QN8=;
 b=dI2bGvg3S+hz2y3d2TlRdGBD5I1iTeoT2GMwbyh2l0EAk99lUxfg+Svets7aMIpVOE
 bjJWDMzBSMup6it+YMaiJraGaq97V175wa1pTzG98GdUHho59GyYuRNEldyTZ3TRvwAI
 EQWnQE4W7qUrTwPKFMaideE+nIi45Q7hHcHaNfRynY5Fy5CaFL0Vrp65bmPt3TzvhUZB
 vcP1nzHogIBcSThh6AbHKiDkzS/9OOBFBBVtVn9x8XRPZ0eHmhSyX1f4Sn0KIkcunACp
 IhoyrjJfjWgR4pgPzBKMmpMLOnCqiQ6IdFhjhUyB7XTVCYen9qy0gIBkyPEzXHs05kLi
 PjgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGMTy6P1XLm0nCbf8ixVXIf6ppLrMJ3mgxqKuyaAA+KX0yj2C0UhKmSobh5HbgjuEE7Og=@dpdk.org
X-Gm-Message-State: AFuF++kGfK5XCYRRyfl/5akKL0TizlFg/SrdWvOZTniBXi5VoeTgdGAI
 HqBNDShH+eicmwwz3qhuWcgLLZpPgp5SKPVVZ4DB56dwUprPxX4I32Rbkg5DMNUwR2tINLgrkgM
 0MrDzfaGpjpmGbWiE/FW1daa/1GY09gB8ZmcjKe2nE/wXTw5nP0sCJxzhg79NGs9JffMLzRoksA
 CfLERkMAk6JN87uuabD28=
X-Gm-Gg: AYBFou0w/wdEYo855BfaMdj3A7SUlVngow2toW/7EWlTJ3DfIL6+9A2zTUenKOXm50S
 Cer8eJN+4tnki9dGvYzjhiiqM9mNOrUlb9YzX3ZBO85arag/f42zjbGkTY5juaZHrtzlqib+xPS
 FmLQHY1dW50F9hnz6OgtYlMkU87YMbofFkVneF5b8uqj7mGaPqbRCptueTfeb2vCyuDWF60pcvR
 2cfQEzCuIrn2VQW1HWCgmGTive+fY+BSrjWApGN8Ld/gG/G
X-Received: by 2002:a05:651c:41d8:b0:3a3:2a41:e33b with SMTP id
 38308e7fff4ca-3a34fddaabbmr7158471fa.14.1788340154669; 
 Wed, 02 Sep 2026 02:09:14 -0700 (PDT)
X-Received: by 2002:a05:651c:41d8:b0:3a3:2a41:e33b with SMTP id
 38308e7fff4ca-3a34fddaabbmr7158341fa.14.1788340154184; Wed, 02 Sep 2026
 02:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260902082523.206083-1-jerinj@marvell.com>
In-Reply-To: <20260902082523.206083-1-jerinj@marvell.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 2 Sep 2026 11:09:02 +0200
X-Gm-Features: AcwNN1UIJ681_fuZ_KwlTQMDXi6WWv_8EPi7ZUxaPXASQwo0DotszgbJtmtSbHU
Message-ID: <CAJFAV8zRf5YuW3O2c7kZRmCTQ_b85DWEMqAE6UjH7ynHO6JCrw@mail.gmail.com>
Subject: Re: [dpdk-dev] [PATCH v1] examples/ptp_tap_relay_sw: fix build
 inclusion
To: jerinj@marvell.com
Cc: Rajesh Kumar <rajesh3.kumar@intel.com>, dev@dpdk.org, thomas@monjalon.net, 
 bruce.richardson@intel.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rXpMUUjq2_RSueYM5OcOHi1bsXk6pyD7RTChwAwEezs_1788340155
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 2 Sept 2026 at 10:25, <jerinj@marvell.com> wrote:
>
> From: Jerin Jacob <jerinj@marvell.com>
>
> The ptp_tap_relay_sw example was not building because
> examples/meson.build was not updated to wire up this directory.

Ouch, the whole example looks like dead code.
I wonder how it was tested by the author...
The series that introduced it has no trace of touching
examples/meson.build in the v6, v7 and v8 iterations :-(.


>
> Fixes: bec00deaa8fb ("examples/ptp_tap_relay_sw: add PTP transparent clock relay")
> Cc: stable@dpdk.org
>
> Signed-off-by: Jerin Jacob <jerinj@marvell.com>

The fix lgtm.
For the record, it is the only dead example at this point in time in DPDK.


-- 
David Marchand

