Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8108FC43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 09:11:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51A40402C3;
	Mon,  6 Jul 2026 11:11:33 +0200 (CEST)
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44]) by mails.dpdk.org (Postfix) with ESMTP id 2F8F64027B
 for <dev@dpdk.org>; Mon,  6 Jul 2026 11:11:32 +0200 (CEST)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-6626b5ace23so4963784d50.0
 for <dev@dpdk.org>; Mon, 06 Jul 2026 02:11:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783329091; cv=none;
 d=google.com; s=arc-20260327;
 b=TESFVelZYrqn+60EgW4eK1DTL4onZkB+PnlU58R3c0AsN4ymek1gs7Hlfn7b0B0qqZ
 VG+3b/rDuPTTj/zx8XoHDFloPW9ZIXVSRIe0Bmt7Jj0qaxt8ogXPyt7PEV7AcJTTCskh
 7llpCknJrZoscwEcX6Shc65EYImkemVyGC2A8MdaD41yrslUhlAfUjjM1QlIdEB7vj3k
 4rFwZ4zYnBq/YUS4AOB0hN5xlGjperA06dAgw0Vx4mB/dT3nRpEzcdA9rXsb/UemyGnX
 AgjUZqrVhc3DH83JQX3Gt8Hi5q2bvBwdl1mbd85rt+8PD2tNPgn4F9OVLkzzSyDmWINr
 eHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=t5FabzaQb/ubd09tHd4TSYVTzQm5PMnHzGuDl1HqzSY=;
 fh=BjgJeim0EpDH8QWNTByuJ1toc0a82/5nb1cOn0NZ1xg=;
 b=FjNGsBn3qsu8OAVBDF6OX2hjkqwkxoaGnJhsvR0HIVP3xRlDp5YVEb8fLimLHVexY+
 lU4bYKqqwK98iW5VhOTJWnc+6+KtY3u0MAYhJNZTmuSuGVbrUHuIMu3Ll3c04rwyQf3B
 I6dw19zI8hcfkwYd+zaK/WXMRB/rY1rX6q+29twEIcGWFeq+2uhcyKGJx3uU7gZLVVPr
 kwqj6o/+U/ir3t6yb58kRp3ST8LADqg+pxngtOyLhMZzt/ATZOSsNOKBo9EVU88Dz18I
 abyCqpB7bM403l06Wcp69x0Ji9zN7TtrkTBvnQbV0DwocWfAsVp5AEg50hN4/IQZv1vb
 VXtg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783329091; x=1783933891;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t5FabzaQb/ubd09tHd4TSYVTzQm5PMnHzGuDl1HqzSY=;
 b=JSt9KWxaa9zLa276jBFxv6RrGvAILHmmEKJk2YD39opNn8ZSMZCCwksTNtV/fgsLN8
 /bsSKFXiwXXiFkOzFfqY+O1AOQhoDaeDz53mmMqcjrTLKA9zCcAkXFe/CJTLcCZgKo7h
 aLb5lKe1PiJFL1HwDybnRYLJWACc9X0Tn+Y80VvycXqoGufSPNQiPwFkYVQ71NJh2fUA
 LIT/EIJn70mdCXsoj/tk9Mg1HPtfUyL8F4/IRVb5DnimT9nEJb5XUSNskPkU9ZAp0gW/
 9nWNJx3iwcuhPP18Q4JZ/s0prwX1CfPZM7+n8dAIwGpg6NHtJgnzgBatPMwuf/ieyIGQ
 vu6g==
X-Gm-Message-State: AOJu0YyvrofUuiWqisGdIZmO4Aiy879UCOC6at2HbNB12Bq6HQpCP/K7
 Bb+GG4/Sf3tcGBH+6wXMEWNUkFf3/K+rDYQkV5IiDnkl9iXgXpr5x9omqpAe3ljtnXHSi8mdBp2
 DXxsE5OzKJo7LoDLOSaW//91TXypZCy8=
X-Gm-Gg: AfdE7cmurshLHO1B32yUO1Qwz7q2n4TVULB3nmym4/dnTElp/Y0+oZoRFvNDM8Zk7H+
 1WtS36NMCE8Px82E99mXYvKNgZyenzOgZ39PjGq36kTDanQJGRrNiaaVlGmGQQrgdtB0+hwF9wV
 qbryVsKC+HJ9CdlotHo8C/10s7Zhik1WTl8/EM0b7OhjY6+SY5BZTtx7vG2ZyxiAXgrwTTyTQKV
 AUxuVnB37E4H9pXziAYTqPPQRcHP0sepgBfdF76VkLSgbZdipETIE0I/RHm9POGKmsDpQ==
X-Received: by 2002:a05:690c:6307:b0:80c:90fd:299a with SMTP id
 00721157ae682-817444109ccmr101683147b3.28.1783329091257; Mon, 06 Jul 2026
 02:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260616102727.708948-1-maxime@leroys.fr>
 <20260630144329.457643-1-maxime@leroys.fr>
 <20260630144329.457643-2-maxime@leroys.fr>
 <19dd309f-a2c7-4ccc-9067-e8116239bcb7@oss.nxp.com>
In-Reply-To: <19dd309f-a2c7-4ccc-9067-e8116239bcb7@oss.nxp.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Mon, 6 Jul 2026 11:11:20 +0200
X-Gm-Features: AVVi8Cd4bWC-zi5h8IuIapcxRafQaUHsX4xDUgvQIMnT6cEv-M8JbIq1QupGOpg
Message-ID: <CAHHRULU2qPcbKjVRq18EWAmabDidbikAOurRgozxk5FHOLsyNQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] event/dpaa2: disable channel before closing it
To: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com, sachin.saxena@nxp.com, 
 david.marchand@redhat.com
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

Hi Hemant,

On Fri, Jul 3, 2026 at 7:21=E2=80=AFPM Hemant Agrawal
<hemant.agrawal@oss.nxp.com> wrote:
>
>
> On 30-06-2026 20:13, Maxime Leroy wrote:
>
> rte_dpaa2_close_dpcon_device() called dpcon_close() but not
> dpcon_disable(). close only releases the MC control session; it does not
> disable the channel. Cosmetic: an idle DPCON generates nothing and every
> consumer reprograms on setup, so disable before close only to return the
> channel clean, as the symmetric counterpart of the dpcon_enable() done on
> setup.
>
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> ---
>  drivers/event/dpaa2/dpaa2_hw_dpcon.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/event/dpaa2/dpaa2_hw_dpcon.c b/drivers/event/dpaa2/d=
paa2_hw_dpcon.c
> index ea5b0d4b85..f65a63a786 100644
> --- a/drivers/event/dpaa2/dpaa2_hw_dpcon.c
> +++ b/drivers/event/dpaa2/dpaa2_hw_dpcon.c
> @@ -128,6 +128,7 @@ rte_dpaa2_close_dpcon_device(int object_id)
>
>   if (dpcon_dev) {
>   rte_dpaa2_free_dpcon_dev(dpcon_dev);
> + dpcon_disable(&dpcon_dev->dpcon, CMD_PRI_LOW, dpcon_dev->token);
>   dpcon_close(&dpcon_dev->dpcon, CMD_PRI_LOW, dpcon_dev->token);
>   TAILQ_REMOVE(&dpcon_dev_list, dpcon_dev, next);
>   rte_free(dpcon_dev);
>
> The ordering here is wrong. rte_dpaa2_free_dpcon_dev(dpcon_dev) is called=
 before dpcon_disable(). Once the device is returned to the shared pool via=
 rte_dpaa2_free_dpcon_dev(), another thread can immediately re-allocate the=
 same dpcon_dev pointer. The subsequent dpcon_disable() call would then qui=
esce a channel already in active use by the new owner =E2=80=94 a use-after=
-free on the pool object.
>
> The correct teardown sequence must be:
>
> dpcon_disable() =E2=80=94 quiesce the hardware channel
> dpcon_close() =E2=80=94 release the MC control session
> rte_dpaa2_free_dpcon_dev() =E2=80=94 return to pool
>
> Please reorder accordingly:
>
> dpcon_disable(&dpcon_dev->dpcon, CMD_PRI_LOW, dpcon_dev->token);
>
> dpcon_close(&dpcon_dev->dpcon, CMD_PRI_LOW, dpcon_dev->token);
>
>  TAILQ_REMOVE(&dpcon_dev_list, dpcon_dev, next);
>
>  rte_dpaa2_free_dpcon_dev(dpcon_dev);
>
>  rte_free(dpcon_dev);
>
>
>
On the ordering: there's no real race. This is the .close handler, run
once at teardown from fslmc_vfio_close_group() on a single thread, not
concurrent with the datapath, so nothing can re-acquire the node
between free and close.

But the patch shouldn't exist at all. The pooled DPAA2 objects use a
reprogram-on-borrow model: the free helpers (rte_dpaa2_free_dpcon_dev,
rte_dpaa2_free_dpci_dev, dpaa2_free_dpbp_dev) only drop in_use, and
nothing un-programs an object on return, the next borrower reprograms.
The sibling DPCI close handler confirms it: it does dpci_close() with
no dpci_disable(). Adding dpcon_disable() here makes DPCON the lone
outlier for no benefit, an enabled channel returned to the pool is
inert (FQ parked at unbind, enable is re-applied idempotently on the
next borrow).

So there's no reason to treat dpcon/CDAN differently. Dropping the patch.

Thanks,
Maxime
