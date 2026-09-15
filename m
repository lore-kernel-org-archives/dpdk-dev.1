Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF08EC88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 10:51:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95B3740A7A;
	Tue, 15 Sep 2026 12:51:12 +0200 (CEST)
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by mails.dpdk.org (Postfix) with ESMTP id BE28040A7A
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:51:10 +0200 (CEST)
Received: by mail-yx2-f12.google.com with SMTP id
 956f58d0204a3-66e56a1fe83so121841d50.2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 03:51:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789469470; cv=none;
 d=google.com; s=arc-20260327;
 b=BVU2oKFXUaVcT+yBOL8gcZ/yo0PGQrewszG4O93mv+D7ZlQ4wjWe695Ju8aCCoOOCq
 IqnTJjOu8gPrHEhwEK7E3e+9DEhFww9OTXfl2Dq5EaXgyShUZrwsGNZQzU8c63QyisZn
 PHynGHUla4mQMG8Dp8Uda+rUsX+qcllnXhgatlfa1LuJ0rgVGHL7FA+BHyJ+tSdDRL/x
 hXuCxH5VCSV19lP2aJIhMnuca93bbV7xF8U54Qumyrx1OokRhOJupCRMIE02OKIm24S0
 CSJ1MAdGLq441GhacXQ79EfY5UnmR2SDN4nGKVvo+Dxe/AH40f8PK+X2tVECWDHPPjgL
 xgNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Dm/BvaFamTFIUBaEzsxJ6eZQzJ4DqLJ0/IZgXhJn0S8=;
 fh=BjLXOEx3itSMU0dDEa5sEgns5DcpNzenJpQvin17x9E=;
 b=lx1YzhlKliOx/RX6pzZIkVPGm3RDuUES0AHlgaoLqeK4nv2oGOkaFKYkNDRp3F6hAt
 K3wq2w0X68zjSIBug9XyDJcdpwy04b4mtTHqBk3Vzlx6RgIXZjyiikb1UBoYonRm5u5N
 mjzjaTHFnkolAusa9Ykfa60TlVvbwxo2ZjToMoM4mZIR0o3/z1iptHp9jQT3jmM+yi6n
 +1bmloIf+0Ys46SKlsIO/UOQ4VrNMdRVhcvc2pGfG4Xw2DUzRPY+5I1nsZZdjY8XwdCe
 1HcMWqUe46iGskf/DVNz83aknnfiW7Ocb0qI2HT2BNHOD5kDBnxBQ10YkN8VxgatdRMh
 +y3A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789469470; x=1790074270; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Dm/BvaFamTFIUBaEzsxJ6eZQzJ4DqLJ0/IZgXhJn0S8=;
 b=Ykc+I5gYMn7SXYIYzEIJz4ZKdy+fuu++OHySn6zshSYVD1JoWbLk72f3UYpn8MuOct
 j1bcNoqnfeTzJq5jWdqAwPoMcQ+AhF9rFbVs2B57MR2/a+4DkWzGQL+Y19roRzyRx/jS
 ZU9lnCZnRecngtj4ASpI2RdEJXmhf5U3rz3i/AbuKQHTOkxzT1flAXI/2Tsewn/2zs8q
 kuo2elYDR0vRCfTMTs7V3gl9IGOwXIGhOn8fi4DmZmPg+XmOVZHzGOptLrBhmxhgcauY
 XVPqGLrWUQ176XrG/gaNUQzDqkT0byjR4zyYTRHVsvMx4AOFnFV8lNW0Z8iyrh+wyVNe
 DO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789469470; x=1790074270;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dm/BvaFamTFIUBaEzsxJ6eZQzJ4DqLJ0/IZgXhJn0S8=;
 b=mWTpVQoEKqGmmf958Rx4gActBpFR4lttys4O2nw8NE6M9ZsAwKpJWtEOyqAM4akd3q
 XVSiiN8EoAkczzpcZKG5yX+Q8cLKlNhSEZoaf3qXP8dAvd5D+JRKMEV5usdoM22tSdfT
 c1EbT1VbVk3O5wCiyPN8xROkY8X/5MDqK0SyW8LWM1xzYsL5ONvpFhzubaYwjT1RGKtN
 xPyRlnyXkHzBBcRLSXcoQ+F7xxiIl/z91tgChDhDNDcxAiXQxbSsxC/A2UK3DLuZhU5R
 s0pq/E93aqqSeplX5S7AViPvBd+MHsN8+Q4JhNyTKTsVVoblnS3dSLZERmLtFmm6cH6k
 XJ4g==
X-Gm-Message-State: AFuF++lWTSJYvvd/eSdaOIKG2NQWZKjqoSDQ3uqbytAZeFVxXfJY4LI7
 kwZHqv2uQVI4qnRD/FRBLJAE7NsyvqKg9dg2HUKPkPxvvgLWQPpEkLasXAmhCiZWjx+75cVIDRp
 VvZjN4QZaqCV2H8nNZ9cjXdl0ZCjzk910YAa/
X-Gm-Gg: AYBFou1/0ioT8Wy2ij7PF89p3jVZjJrnDglMorY5TclZMBLJzJoPxtQCSD/fQdOf13k
 OpDt6OCizJcmioYl3E6zsrqQOXQAq71k2qQP2R/0g9S66T7vhpFi19H15HmU4VWQgQGUqGgRygu
 ngY3cUnOxdtvctJJdZYK+bH7A2fu5D+awSiZ2+gm7uaMLSH8GxhChalOaTtCZviN+O/RB/9v0zJ
 vGtzq3tBMEnYER61k6p/XwwWAuCE7jHZIHh8Acc2jdS/5B5UlApt6Mkc6AweYyy8CgcaZYCUqoj
 u4mtT8plJWwGaSBZ4F9wUXKtaDRf4VYgzn4xO/kXwJs8GVkQPZsNcuIMjXkxXZvCLoYThFcO3t+
 iaH7izR+KtCTAD84yBSTabCfugR3F2GAqIIX/ZLWvIy51PprftMi1McweaSusDnW8GkSDiF15fR
 Bw3cAmPpNrUGNlYUp+Kf7AOvANh7M=
X-Received: by 2002:a05:690e:1201:b0:66f:c1be:3186 with SMTP id
 956f58d0204a3-6715cc1dfcamr127375d50.93.1789469470112; Tue, 15 Sep 2026
 03:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260729103236.3878391-1-dragos.tarcatu@keysight.com>
In-Reply-To: <20260729103236.3878391-1-dragos.tarcatu@keysight.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 15 Sep 2026 16:20:42 +0530
X-Gm-Features: AcwNN1UfHjfTUug8ZRjgZwbfLcdpddqMvFY6QsYQaFExvG4ve4MrCDyyVdsKn08
Message-ID: <CALBAE1OZL=dFQj6pzxorVtet4h=o7R1bC6N5-eaUvjX+s9+X9Q@mail.gmail.com>
Subject: Re: [PATCH] examples/l2fwd-event: fix memset of port statistics array
To: Dragos Tarcatu <dragos.tarcatu@keysight.com>
Cc: dev@dpdk.org, skori@marvell.com, pbhagavatula@marvell.com, stable@dpdk.org
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

On Wed, Jul 29, 2026 at 4:12=E2=80=AFPM Dragos Tarcatu
<dragos.tarcatu@keysight.com> wrote:
>
> port_stats is declared as struct l2fwd_port_statistics[RTE_MAX_ETHPORTS],
> but the memset passed sizeof(struct l2fwd_port_statistics) -- the size
> of a single element -- leaving ports 1 through RTE_MAX_ETHPORTS-1 with
> uninitialized stats. Use sizeof(rsrc->port_stats) to clear the whole
> array regardless of RTE_MAX_ETHPORTS.
>
> Surfaced as a -Wmemset-elt-size warning when building with
> -Dmax_ethports=3D64 -Dexamples=3Dall.
>
> Fixes: 4ff457986f76 ("examples/l2fwd-event: add default poll mode routine=
s")
> Cc: stable@dpdk.org
>
> Signed-off-by: Dragos Tarcatu <dragos.tarcatu@keysight.com>

Added the following

$ git diff
diff --git a/.mailmap b/.mailmap
index 9b7713b6df..52d19bde6b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -428,6 +428,7 @@ Doug Dziggel <douglas.a.dziggel@intel.com>
 Doug Foster <doug.foster@arm.com>
 Douglas Flint <douglas.flint@broadcom.com>
 Dr. David Alan Gilbert <dgilbert@redhat.com>
+Dragos Tarcatu <dragos.tarcatu@keysight.com>
 Drocula Lambda <quzeyao@gmail.com>
 Dror Birkman <dror.birkman@lightcyber.com>
 Dukai Yuan <dukaix.yuan@intel.com>



and

Applied to dpdk-next-eventdev/for-main. Thanks


> ---
>  examples/l2fwd-event/main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/examples/l2fwd-event/main.c b/examples/l2fwd-event/main.c
> index 2d31d4c6ad..eff2bee503 100644
> --- a/examples/l2fwd-event/main.c
> +++ b/examples/l2fwd-event/main.c
> @@ -696,8 +696,7 @@ main(int argc, char **argv)
>                 l2fwd_poll_resource_setup(rsrc);
>
>         /* initialize port stats */
> -       memset(&rsrc->port_stats, 0,
> -                                       sizeof(struct l2fwd_port_statisti=
cs));
> +       memset(rsrc->port_stats, 0, sizeof(rsrc->port_stats));
>
>         /* All settings are done. Now enable eth devices */
>         RTE_ETH_FOREACH_DEV(port_id) {
> --
> 2.34.1
>
