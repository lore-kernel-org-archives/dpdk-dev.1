Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA29F54AD7
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:35:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C59D402BE;
	Tue, 24 Mar 2026 17:35:29 +0100 (CET)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by mails.dpdk.org (Postfix) with ESMTP id D3C0E4025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 17:35:27 +0100 (CET)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-50919fc3a14so44586591cf.2
 for <dev@dpdk.org>; Tue, 24 Mar 2026 09:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774370127; cv=none;
 d=google.com; s=arc-20240605;
 b=F9d7xgHlzx02z2U06/Thm70ivP2/MucA5xQtXysFfQLaChrs//rI5Fd5Ets7KlbU6+
 YngOfkhVoSiVyc507fjWSrEXGrs6R23UAvopZ0WRbwr9petAe1z3xbyg+Grc/p6d2S0D
 Gk4Yr7NVQw/4w3tyHXhr33xHI4QkX61+AfprIdixehflZmLHj2Wqfam9MKPzQs4qU6fZ
 k0ocM/ZdL4LiqlBPE1C4qtkK9dBZ5ry11yqgNcbGarlxeYVHrcTvl4ECbN6TP101BVyT
 Zp0GwQZuvKZnxG81ICOOCdKfVDU8ECc9UroDkcJiAQdd5NcHA3shOMTlxQJR6oGaGG+a
 3+/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=D+XL4j4WdWlgkUUFMhLR3PXk92LSWRyiFDZBbQIAX3A=;
 fh=ljFba8muIy0pSbcl4RdTkGMTlDt1ifC75IX1zLUeCGE=;
 b=TLj7M5cv+HHt4FtaSZwp3ZdSpAKif6DyyqqM96f97BPO9jUOBwZxtomkHm7+2SZEL8
 6LbANel4iWeep9yVJi0inrzHNTw56zQ2eI46jFWsSevJ6yw+oFLQlYVrtlX4+f/f2x9Y
 svbmH8+ekJY4G8J4RrnX3SiRDij3GBgxYsynAa7oQ83rw5RPiBY+irI4XuRgs8WlXNEI
 nNfVjHFhGhaIKHbhTldSrmLeYkhQy8xdp1tkfPq5Ox6FH+MY1JXF+ql3tjV5a5qnxI7j
 AvMOdArpY2y57wDjcgn6w/SXJxGgj8XGnyLl/5MhZk7zNndsghloc5r7ICr0ua5yPUGU
 WqvA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774370127; x=1774974927; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+XL4j4WdWlgkUUFMhLR3PXk92LSWRyiFDZBbQIAX3A=;
 b=ikJ6V6lj9EP/ED++DGDMMG2larxJdpFVp8AzX8ZAEtPsBzpoS8QbCz6XnDlN7poCPM
 PLs6PvaXtsI5JvARbx3GWuf76pWfiiu6kI/eHIYp0LVZ0eFDQ37gS1aMt/CQTD2L2SOV
 RQeWfj01JAcAPXmHKHGWDtu3Fg89lOVj/T+WSmYsbRb2NVuUJmL11WrV1/pilNuUvO3H
 SyQlZFIsMmuBMiCBjA9SemThb1CllUqDfZysEJyhyh8ewsO+tRU2u522PjfPIio3A1qu
 A56yQKROkAbNTVDKe03iEu99K7jVze6cz/QSdFN2ymRH/4pSqNQuN0jnL0wIhWQQpjeU
 hGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774370127; x=1774974927;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D+XL4j4WdWlgkUUFMhLR3PXk92LSWRyiFDZBbQIAX3A=;
 b=fgcO2NkPjeJ0xD/q18+IA2SzGF2HFrppvgV1bYkgykzj6jAwUrCmSOCz2V51gutGqg
 wH/xfXYA4ce2B8zhAcnz7NDmAfRrBHNvDRyUTr56IzmGXyNzFbHO7eWImygHKm5rAPDu
 d3BAXlBVwEzknL/ylp51vEcp7n2+nskhV5MR+AXwQrwRCeygZ7tZz546a7/zX36lP5A1
 P+3aYRAGehmlaa4szf++uLtB3esaZZBQ27vmHHjUqtkimcsMz4nxIEZi9vYDEGb6gC1j
 G6AB5eaQpKRk7LYyjNmOH5h2J3h4Qo67niNL7BhV/0enaHHzVlMGaRNpbCb+Kdvc5G/z
 lI/w==
X-Gm-Message-State: AOJu0YxHgs8kEdNSqnNzJ1cZLj0+SBYMNKFev+lixnP8bCz/W7JVQztE
 CF0Fi4iNpVyP5C5jAXiyBuk3KXuUX4HSEKmEVhiL4zXi05AAQd+kdbUo03X6C6d8zig4FpmF/wg
 bS8QdiN0qq6pkbz+kn2sNiD2IcQV4FGc=
X-Gm-Gg: ATEYQzxsizFjsQpzUY4hyz49eIQmoGgOZ9m22TB9uHf0Ghz7WLG/Vk8fBvfiF8T3O03
 tutLfrSVO4uRVnY8Tdx246vw24eGdsjs1bFtjKfmDmZ3a84S++6Es6IcGPCqFXfUccV2bVXVGCF
 4dKu33nRQKhUqktZ7PEVvb9nvIBdgO43f6OHQwDAJn+AvD8aK9Pg78GvCKKQi6rO+SJiovvHwzE
 eopPgUB+Be1+pX6z1ZuIerBKAArMf0WH/8eIT3ZSQYwzJC3qqpXYJ9Dl/AHnjKM7aMcxUjusVzB
 4xg=
X-Received: by 2002:ac8:5c8d:0:b0:509:5bd5:6be3 with SMTP id
 d75a77b69052e-50b80e458bbmr4263621cf.57.1774370127075; Tue, 24 Mar 2026
 09:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260316061635.4178854-1-nkishor@marvell.com>
In-Reply-To: <20260316061635.4178854-1-nkishor@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 24 Mar 2026 22:05:00 +0530
X-Gm-Features: AaiRm51AkRYE3ThlgJU_gA8AjGlkIpVyvG0aK_HRovlXS4xVixFFHQoukcfrKfY
Message-ID: <CALBAE1OarWvWwP1Y_idy6jxaAb8R+KtLB5oAm0vzKg0NBryryQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] common/cnxk: fix width of dpc set field
To: Nawal Kishor <nkishor@marvell.com>
Cc: dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, 
 Ashwin Sekhar T K <asekhar@marvell.com>, jerinj@marvell.com
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

On Tue, Mar 17, 2026 at 12:15=E2=80=AFAM Nawal Kishor <nkishor@marvell.com>=
 wrote:
>
> Fixed width od op_dpc_set member of npa_cn20k_pool_s and
> npa_cn20k_aura_s.
>
> Fixes: 143a419edf35 ("common/cnxk: use new NPA aq enq mbox for CN20K")
>
> Signed-off-by: Nawal Kishor <nkishor@marvell.com>

Applied to dpdk-next-net-mrvl/for-main. Thanks


> ---
>  drivers/common/cnxk/hw/npa.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/common/cnxk/hw/npa.h b/drivers/common/cnxk/hw/npa.h
> index e421c70e01..0c7a8923df 100644
> --- a/drivers/common/cnxk/hw/npa.h
> +++ b/drivers/common/cnxk/hw/npa.h
> @@ -375,7 +375,8 @@ struct npa_cn20k_aura_s {
>         uint64_t fc_msh_dst : 11;
>         uint64_t rsvd_438_435 : 4;
>         uint64_t op_dpc_ena : 1;
> -       uint64_t op_dpc_set : 6;
> +       uint64_t op_dpc_set : 5;
> +       uint64_t rsvd_637_637 : 1;
>         uint64_t stream_ctx : 1;
>         uint64_t unified_ctx : 1;
>         uint64_t rsvd_511_448 : 64; /* W7 */
> @@ -446,7 +447,8 @@ struct npa_cn20k_pool_s {
>         uint64_t fc_msh_dst : 11;
>         uint64_t rsvd_630_627 : 4;
>         uint64_t op_dpc_ena : 1;
> -       uint64_t op_dpc_set : 6;
> +       uint64_t op_dpc_set : 5;
> +       uint64_t rsvd_637_637 : 1;
>         uint64_t stream_ctx : 1;
>         uint64_t rsvd_639 : 1;
>         uint64_t rsvd_703_640 : 64;  /* W10 */
> --
> 2.48.1
>
