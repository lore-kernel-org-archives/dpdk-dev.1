Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823FFD58E48
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 16:40:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B83BF4025F;
	Mon,  2 Mar 2026 17:40:47 +0100 (CET)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by mails.dpdk.org (Postfix) with ESMTP id 295F5400D7
 for <dev@dpdk.org>; Mon,  2 Mar 2026 17:40:46 +0100 (CET)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-4638e238094so2816535b6e.3
 for <dev@dpdk.org>; Mon, 02 Mar 2026 08:40:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772469645; cv=none;
 d=google.com; s=arc-20240605;
 b=E7i1i2cqJ7fHJ6epm7Tsv91mYKtqgckDzpInS6ePD/zMHWgz5cgrKG0tKEEs32fIu7
 WLv6phuLzY5M+nOgxB4kT3++7AOorwyc73tuTn3aguiAPyNXURLoR6n6kTPXOylDfXgn
 9DTzgzB5XU9Ljz23AczTqQH0a6ycSSstDidmXtTuA1fGoizFnbD2SnMlL7d3rSASl1Pd
 8la+TowBwus5zq2vuJ077wkrgBFADWLvToYsG9gdL3RZCrxoxw/vFe6f7qE6P4RvM5np
 kkcpB7r9W/cddmaQDJNyQ3oQtNqMcFakhyoW8wSe+o2CESJfcrOHFKHtYx19rOOKGyPk
 IYBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VFlDi0EgEEyKF3rAq0slerndIkk/1ueVJ2NMhrC7eLE=;
 fh=FFvYhBMpl5E14XyJ5ORX98Ze4mQ/s4i0VoHij9ObGjA=;
 b=D3edc8GnFmYQ5rRC6Fa+6Rh1oglNGOPxlZDlNNy13qqbJRxhp53Zm4JgmyUNgYtjrh
 u6A2Vo+uVCl0P3fVU6toqlAma0Qwwe1HExyRWM7mbCAVUsOVrc4I48e9HaAqGJJV5SYq
 HfpW8SkkNIwAnCe/dsszpviQaWBmo04E6b8r3GPc88qQ1YaMHFLJtbyAB7B2LPBi93ub
 LpFF646+ISIPWC02flI7ctQxvzcF0mUw86bMSRssGuzquuQ80lFXg6BzfthdbzWr7N1h
 RFiaPuxUDTh8fz0vV2aTq922uGI8fyL1e+A1JNX7XzE5HnbhDRdUa+wyxxYnPcsb3Rbu
 nojg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772469645; x=1773074445; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFlDi0EgEEyKF3rAq0slerndIkk/1ueVJ2NMhrC7eLE=;
 b=aaq1NsSsf6Zy/bewllGSSgFBCfTUwrsjnJrHtJn3uDTZq0hbiIfKY6t2T4lyU0Sazp
 tKXwLvFPe7uuNEM7IkUXrSDVNhfkCpZPEMpAHwfKvNSCpliu6or2LL8oja9wCAdS5d3K
 VTtMNMByl17D1gN/t+lOXm0rAqc0t50LfEbWAlRoZPsHwkjS+9K22/MJo6uS5rsuZcio
 11lA2uftIhkwx2CHZZZUfV4Sy2lilXrJDrCaU3/xr+eNujWfYwp1vD0R02iNQjivgVkY
 fWdVOxSc5O3Wdyh4AP1OS6h7chHO9RvS9Gv9et91jHOGlYQdVw73b42uBk3Yi1xijxfx
 ZBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772469645; x=1773074445;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VFlDi0EgEEyKF3rAq0slerndIkk/1ueVJ2NMhrC7eLE=;
 b=GAeo9k3SG1abMrYYPzDksb5eyloDSeJGx+n872BSNC4iCC26GtPtEBmQfDyuJzdzzg
 KQmezWW4pOPniLf3jg6Y1mS+PDYi7SgwAistpcjcrr5OhWkCg0tDizkNL3yLzGInjSfh
 yyhS/+1/vRk6lTaB9nu2D6FQa0QWBwzEjrMFWu8GzKTF2lRdfc7/4GGsmNsEZq4v7qer
 mFvTMhWjZKuXaqfwpkzIYo8PSWccS+wG6E4r0VTFCbF5yzOe7OIK1xGtJXT4OcyI+V/n
 74SG1wenty370Sa7pi6Ui4/RkByn6agd1AbF5dZpcZ9DHpP0Po+xlYMUzw5AECMTsNmy
 YNOQ==
X-Gm-Message-State: AOJu0YzUvoh1bXcl09YEPb5uUk1VXyJSU7IrkzijTeO2xgJJjSK7Qpwg
 0ctFFWVo7G7UMF5JjjRubS59mGHk4wWk/MsHjT2jq55Ln8V2PvD2ldKkDjOkbCUTTZv4BATK22B
 ftnKHDBHXxeQ6IK4NUIGKf3fGmyEVPo0=
X-Gm-Gg: ATEYQzx4Urw9BENhOCqpGSIHDLeOBOOtqmot6ES9IwG/BxGNYlNfFS9b/lwYcuk7kq9
 q4MrIwMqmkWMyM2aJjSlwmE+FlUXzT4l9M0QAPq55aVWrRmsaZYysJ0VHwJpUWggECJXCGdYTlf
 0tsG/SGu0JHrM8bSlnAW38Ee3CoRAnDPYmYmsn3bUn2Pvfy629JXHzZnot2NGOpHFqiitCUWc3S
 /wj5KB+O3bTqbCr+sMeoIkb2UAX44INARVzobEM1xOVLYMHnoi5U0zO0l2+amUy8AfGSoQ75dcn
 lzM=
X-Received: by 2002:a05:6808:318c:b0:45e:e173:f9ac with SMTP id
 5614622812f47-464bec48242mr8140599b6e.55.1772469645068; Mon, 02 Mar 2026
 08:40:45 -0800 (PST)
MIME-Version: 1.0
References: <20260120195418.466318-1-stephen@networkplumber.org>
 <20260205175750.653353-1-stephen@networkplumber.org>
 <20260205175750.653353-5-stephen@networkplumber.org>
In-Reply-To: <20260205175750.653353-5-stephen@networkplumber.org>
From: Nithin Dabilpuram <nithind1988@gmail.com>
Date: Mon, 2 Mar 2026 22:10:33 +0530
X-Gm-Features: AaiRm52vXCHGdGlDgL3OM_lyOHPltbLZaqjgGiu4SnJFEjNAVZva2CG-0ykj-fU
Message-ID: <CAMuDWKTM2MLVgHnzzPq_kia3i+o+HuvnWFeo8oRKjzpyrvS+aA@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] common/cnxk: fix buffer overflow in SA setup
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, rbhansali@marvell.com, stable@dpdk.org, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, 
 Harman Kalra <hkalra@marvell.com>
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

Acked-by: Nithin Dabilpuram <ndabilpuram@marvell.com>

On Thu, Feb 5, 2026 at 11:34=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> The nix_inl_reass_inb_sa_tbl_setup() function initializes inb_sa_sz
> to 1 byte, then allocates a buffer of that size. However, the buffer
> is subsequently passed to roc_ow_reass_inb_sa_init() which performs:
>
>     memset(sa, 0, sizeof(struct roc_ow_ipsec_inb_sa));
>
> This writes 808 bytes into a 1-byte allocation, causing heap corruption.
>
> This bug was detected by GCC's -Wstringop-overflow warning when
> building with LTO, which enables cross-compilation-unit inlining
> and allows the compiler to track the allocation size through to
> the memset call.
>
> Fix by initializing inb_sa_sz to ROC_NIX_INL_OW_IPSEC_INB_SA_SZ,
> which is the standard macro used elsewhere in this file for OW
> (Sobek) inbound SA allocations.
>
> Bugzilla ID: 1513
> Fixes: fc9a711b5c8f ("common/cnxk: add NIX inline reassembly profile conf=
ig")
> Cc: rbhansali@marvell.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/common/cnxk/roc_nix_inl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_=
nix_inl.c
> index f8be98efd5..1766f68c17 100644
> --- a/drivers/common/cnxk/roc_nix_inl.c
> +++ b/drivers/common/cnxk/roc_nix_inl.c
> @@ -583,7 +583,7 @@ nix_inl_reass_inb_sa_tbl_setup(struct roc_nix *roc_ni=
x)
>         uint64_t sa_idx_w, lenm1_max;
>         uint64_t res_addr_offset =3D 0;
>         uint64_t def_cptq =3D 0;
> -       size_t inb_sa_sz =3D 1;
> +       size_t inb_sa_sz =3D ROC_NIX_INL_OW_IPSEC_INB_SA_SZ;
>         uint8_t profile_id;
>         struct mbox *mbox;
>         void *sa;
> --
> 2.51.0
>
