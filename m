Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5ABC44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 10:24:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18FCD402A7;
	Tue, 21 Jul 2026 12:24:25 +0200 (CEST)
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44]) by mails.dpdk.org (Postfix) with ESMTP id 59C5C40289
 for <dev@dpdk.org>; Tue, 21 Jul 2026 12:24:24 +0200 (CEST)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-664a09bc459so15115901d50.1
 for <dev@dpdk.org>; Tue, 21 Jul 2026 03:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784629463; cv=none;
 d=google.com; s=arc-20260327;
 b=ZgzRF2p+lbaFYx74Fm54YiNMtnXyKRgEQ9r+iI+YhrjYtDMsMGYUbn9x6VG6/JpsXp
 ZDiUF87N4y37lg1xHv3EYt12j2sjMgAxy5veZa0D7357HAyvrZ1XVN1EAlbxjEQGTiP/
 g5J37tysekBUD+9GxjOS0fVmysbpHQsZEVYSYw4sGWkU4I+7RPKz6kX/gIihay4yxk7B
 tO1VicfK8IfkAr39r46s59BeHGQVp6aw6yhEaBlMWAEsI2jiN4Xg7sdzbSG7NX5rf5Nn
 Zup6cKqtX3RYwYsa4SRSqH5h9BY8sAmMftfA6DJVavrse3C+jTCUjGS1jCgAh7Tf44sr
 t26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gz4IVLfTcm53kyMaf4ca7StK207I4OQacC8kXGbV+Yw=;
 fh=Fu2QypkQn1X1moU+X6TPX6ikDVYUQlxaQQcy3X+AIZM=;
 b=Vz4PKuhh7iXo/njQFWKMQJOL6YVrt1S6L2q99MfkF8etgKHBSKNblgwA7+4thB9B41
 773pSgnJR2O9Fhva5LX1H+dQCXWPed6BODt87hdRThoOsRK/I83rXgQGrA3jtl8qookY
 9Vj5+YKKOUYZCPCnrTh4PE4jmvd9NoQRV5daK7qR160GSlUmsSAcMgb2w2+DU5ufh9IV
 Zq96aOIWXjDKqPxsYvuI6t5/p0b4MpWj/9xZASgqTYDyb5GCo2mWWv+rnUGKzivEf3iA
 lqbbZCWpRKr2ypsNzjWCTK1458OX5bB5PVOiVA7HMUiouDKXqGmrEYaXvDia/wqIWmB2
 A+fQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784629463; x=1785234263; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gz4IVLfTcm53kyMaf4ca7StK207I4OQacC8kXGbV+Yw=;
 b=PPvAF0/IUptloPjlBFDwBX1YsDk3N+6Fc5oiW2WxUymoXcTR9xetAdBPM8n5jQ+xYU
 4yD6Mx9dkhiY2S4DVRB6zqXdJ9XbH2YdepndqrxTYn4cqr3q6ZcFTFp5b2oTx+iU2LDM
 D9LwHuTzWBaRMsxHbg/z0GRxoHWOez6dD6yFiTIt/QxRYvpQvZELtqopMEBLKUC8cDMp
 /8Uizx3nWm62DJD5LglPUQ80bGQazvVeb6FQB//MyScSRxaysXL1SaW6KJ2pr7N7N6lg
 ACOGOoKNdY9PuJttu+pGiO4MihN6fPZka/F/2MBhaK5iv+kz37WREfIiBw+vjXwl6EWM
 rFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784629463; x=1785234263;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gz4IVLfTcm53kyMaf4ca7StK207I4OQacC8kXGbV+Yw=;
 b=WFLPozcQ4tYaMYrIjIFm48c5FsMPRSWrlq+qu5g/M3VFpLdBdl/dSRYkz74+/9CDDY
 Ah81dkJV4W4smaygAys43n8ERUswDsK1c6fTnJR2R6HypLENZ89CY1Qc80hDRKh8BBcr
 3Ks9CpUN9dCcKhiu2G0G0YjCZe3y6OrgPkyLTeGGS3FianrNYh9DI1yKdwyZ40r8ZMh7
 vvJ/SJycjEQjNgdz2HH+juQTbJaVPKxyN857dvLBU1pRWDzyFktA4vMe5gDsW6Eru9ci
 70hgN6BPbUGmxfdne7KxiZlBDVhOiqIokIdP0YGKJ9gCXbHfr2KDxOYwgsnxTpNWzXek
 7l2A==
X-Gm-Message-State: AOJu0YzSTkBLw8+vZ3cMS8rGZ2FBzgO2DF9CbzoUT85iPWIZWTGTkrap
 fCRUFGIGjf3yotkLVcaPklN5tfZTcX3LAUkidOor7MNA1r7Ga7Hg69yr7o2Lq2VpJQSmd0nvWMg
 wM8sYskAZSl0W5PP/k2FN1HVsm7foldg=
X-Gm-Gg: AR+sD10oClHwLKH1XoWY1lQPuYIfLvSLc6/ylxHJLYYTJmNViZz2I5unSyGv20ieOWZ
 v1aXOtqjb+ylixmmUv7QYscs6Q8+mw99cZQ0xJvgIcW14X+7QIRivjdUgxC+ypKJ0Q40bngZ7xk
 v0MPW7Wx/ccHMyhidhv16PTxYpA4oH28RzS2EQD8dlzGC4TSghp3VasIXF4ZOtwi3SiJnD0wQ+i
 i3+scXa/e+ZC6x+4XqUOR0Ms690pnXgEjAG7OjpOHQxsvoPAo9fzBnpoovYnQTmoI4d6PgbKTZR
 hzqkx80CqYYWUGkbqp1ynQOz9/fpyIL4mMZQqg==
X-Received: by 2002:a53:bb8f:0:b0:667:e855:ec85 with SMTP id
 956f58d0204a3-6683bbdf79cmr3263762d50.12.1784629463625; Tue, 21 Jul 2026
 03:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260717090121.1859773-2-rjarry@redhat.com>
In-Reply-To: <20260717090121.1859773-2-rjarry@redhat.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 21 Jul 2026 15:53:56 +0530
X-Gm-Features: AUfX_mz7FWox8rm--xdbBaloHrLqvodhzcwWnIWt5gE678ICSQ0N_-r9FNGUlgs
Message-ID: <CALBAE1OmG3d4=63YfqYCs+ZWWVzitpCcTBRTjr5yhLA-RZGgmA@mail.gmail.com>
Subject: Re: [PATCH dpdk] doc: announce rte_graph ABI changes for 26.11
To: Robin Jarry <rjarry@redhat.com>
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

On Fri, Jul 17, 2026 at 2:47=E2=80=AFPM Robin Jarry <rjarry@redhat.com> wro=
te:
>
> The graph library internal scheduling will change from a circular
> buffer to a topological bitmap. This affects struct rte_graph and
> struct rte_node layouts.
>
> Signed-off-by: Robin Jarry <rjarry@redhat.com>


Acked-by: Jerin Jacob <jerinj@marvell.com>


> ---
>  doc/guides/rel_notes/deprecation.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/=
deprecation.rst
> index f5c12cc74762..6183f33b893a 100644
> --- a/doc/guides/rel_notes/deprecation.rst
> +++ b/doc/guides/rel_notes/deprecation.rst
> @@ -61,6 +61,13 @@ Deprecation Notices
>  * mempool: The object array in ``struct rte_mempool_cache`` is oversize =
by factor two,
>    and will be reduced to ``RTE_MEMPOOL_CACHE_MAX_SIZE`` in DPDK 26.11.
>
> +* graph: The internal scheduling mechanism of ``struct rte_graph`` will =
change
> +  in DPDK 26.11. The circular buffer fields (``head``, ``tail``, ``cir_m=
ask``,
> +  ``cir_start``) will be replaced with a topological bitmap scheduler.
> +  A new field will be added to ``struct rte_node`` for the scheduling or=
der.
> +  The graph walk functions will process nodes in topological order using=
 bitmap
> +  scanning instead of the circular buffer.
> +
>  * lib: will fix extending some enum/define breaking the ABI. There are m=
ultiple
>    samples in DPDK that enum/define terminated with a ``.*MAX.*`` value w=
hich is
>    used by iterators, and arrays holding these values are sized with this
> --
> 2.55.0
>
