Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE741C55175
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 09:16:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D25A402E2;
	Mon,  3 Aug 2026 11:16:26 +0200 (CEST)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53]) by mails.dpdk.org (Postfix) with ESMTP id 7AD6A40272
 for <dev@dpdk.org>; Mon,  3 Aug 2026 11:16:24 +0200 (CEST)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-7eb1dc6bd53so1934578a34.2
 for <dev@dpdk.org>; Mon, 03 Aug 2026 02:16:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785748584; cv=none;
 d=google.com; s=arc-20260327;
 b=RZZzq/+GZbGdTufLhzWwbGWKK4n+wEKQ5g43TAsGGgOhu4AtdXdk7+AD2jhri19LuE
 EpBDBuUuG8H83GGXMH1tSexivlNV8QgZyfU9delm9PFmPUgk2/NqdwXifF8Z3FyGr3sM
 wTdrDvjNXOOsvYX2IfPrBgvW/mX+CoOFf+8Xa8E73+ggXwsEC30kWbRU+6JE7ePsEtDP
 RmK4McQ35yywdDSLuRMAthDqMM6T1KZJ1w0PvOsA7gSkkdS37U2JEM/nwq3D6zO0mw+x
 eTTvGPx81te0BHEgHIeEoARSb6FqiYnhvtFjAvHF35oyu/5z7/zK6UJ0Zu70yWH9G/3p
 j2bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MlHVn2NkDnFPDTnENso1MAQSEQaIomEXyYLFOxVlWc0=;
 fh=DHZTw2arxLbniIV2UDDBWqcUzMSWMyy00ACQCLBUWjA=;
 b=FSBHPEeh58330Med9Ji3bIHpTpXjj5l1Qz2L6xAeSpaBobquJUVVVt85ybnccKSxJ/
 B5RlaOnrtVWKpHJJ4PMpbGHFoLjDDNhQx0iyBrP4oiiP3DVHvScI97pkLMB9aNJcjhs3
 0wdSyYm/61UZ94n9YbqC2Mq0BF8cl8U3wkIPjAsVKgg9hD4J8URGbMFKhRxJf/CrJne+
 mIjGjC7cpFBvZEeN/vTyHJVrDDEjxUIZoqeT4fluEjoZ9nLk8d5Hc6XSeiBLaDIk5jTG
 eI7evsE1JHZRamX9UkUY2Rg0Ylh9IGQVToOCXVu/0xzYFgvseq/XWwaPRCbwq2cP+YIG
 5t2A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785748584; x=1786353384; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MlHVn2NkDnFPDTnENso1MAQSEQaIomEXyYLFOxVlWc0=;
 b=Cj49l4C3dJJ43Udz7cWDwmabwdd9PneSnmd7hqOPJlMXmxdmrn3GDVqMZyi3n7BTqz
 U22MNprRY+QftmD1uVb7E3Fjg43VhIoQViHlvtO8JoHijMUnTsiQJNS8vXm6QKnh2etF
 GA28DWSDL/a9FFjU1ACOgV7Z/F78j4yzpc9r7BRq1qeW5+T7ggdCmt/0jHNBpyZSFEXW
 frtXnTlsUYYruF61mWjCvOag2o2urQ2i0aqby6prfB6yXSMpRCAvXue4/CTWRdXLZsot
 M8fYV9+EhOAlYJU13j5ifZPHBzXzI+Nw9yelOnD11x2convkDeTGsvjnddy/paKLWFvL
 hhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785748584; x=1786353384;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MlHVn2NkDnFPDTnENso1MAQSEQaIomEXyYLFOxVlWc0=;
 b=KkEswRDEMPD9Q9HVIY0V07d+NONoPZSCYOKqgMynvNl+1xc4nfZfXme6i77/8modqf
 5q4qMtik0gNLNgp7b3mlqeqLVanYs68pZM1kuhE5NrQ2ZOTbBhMzHX5DiUa5zkxed+P1
 sQy0ybr9t5t309OntQVS3DrQxlQy0Ow2a6ddWeR83s+BenC3+cDsx7n7IHz3mj/tVXSR
 6I3hAet58qtjp06uZJkznNlKeL7ORDv6CwBP6+tf3kMu0zVbCUK/uLFrrKEol7uTy21z
 rNL+SUxo9sXTqD1QBK9tTXYVZn0pLh8m18aSeIMH+m/UojozmaHFJGLWV6wB5k7iyxMG
 9Ceg==
X-Forwarded-Encrypted: i=1;
 AHgh+RomxnAT7n1Q694HB+aKCtb7XCB6gKF17jYBFWqWmRZ+uGOZTm4lRpNJ051/e+IR16op7jM=@dpdk.org
X-Gm-Message-State: AOJu0YxtnsfgdlQoMAlqIog0r5iqFwoKQwWpY50xdVIT9iuPJv3Jqv6P
 cu9HSFuxc6qY+77VnxFxbfFePwS9nIVirY7lkR+qnkyuNM03m8tcC5OD/e1FBj05H6CSf9pJJA3
 cvtHdjgUEGOIeI6CEebxGSzYvnDnipYg=
X-Gm-Gg: AR+sD10w3x5lGH7CMwQvAic/wLmxI+s4n/9OminxaYi8V56SRwahGbc7F5qFVL3yvrt
 nb65zd1FLRJX0MxyH/LUUT9RAcjhB+Cl/Z2trlW2OVl0cMgmuNdY2VvyDlfLvqL0BruZpt9YK4K
 GTuRssllV91OpqtgxXYvI7tczUYzNzO+OsREwDZPUsJpURLiDUjLhNCFu9Tzdmmjuzi4NlvJPKT
 jDWpBRqAYov/Z0BSb94qku/8KFcHZ7PqnIyMo33BD11og4zfW8FbQ3Yy4gzQ6+UhENmddDlnyBV
 03II28Jlbf5FXK2zaq3gVzqJsbk457uLeetB0LXVchdd4g==
X-Received: by 2002:a05:6830:211b:b0:7e9:c102:333d with SMTP id
 46e09a7af769-7f196f8ad8cmr15229230a34.9.1785748583677; Mon, 03 Aug 2026
 02:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260727211003.22590-1-kobikenzi@gmail.com>
In-Reply-To: <20260727211003.22590-1-kobikenzi@gmail.com>
From: Nithin Dabilpuram <nithind1988@gmail.com>
Date: Mon, 3 Aug 2026 14:46:12 +0530
X-Gm-Features: AUfX_mxayafHvmDpyZb7NRFq-H4--V67Nwd4DRL6Ex0sEsQzgXfrxeKDh_GQMNM
Message-ID: <CAMuDWKS82pVaKkE4rSH9A1NTPZF8JZRTx7QkDFvZ7MBfzhzhoA@mail.gmail.com>
Subject: Re: [PATCH] doc: fix typo in CNXK guide
To: Kobi Kenzi <kobikenzi@gmail.com>
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, 
 Rakesh Kudurumalla <rkudurumalla@marvell.com>, dev@dpdk.org, stable@dpdk.org
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

Acked-By: Nithin Dabilpuram <ndabilpuram@marvell.com>

On Wed, Jul 29, 2026 at 4:47=E2=80=AFPM Kobi Kenzi <kobikenzi@gmail.com> wr=
ote:
>
> Correct a spelling error in the transmit completion handler documentation=
.
>
> Fixes: dd9446991212 ("net/cnxk: add transmit completion handler")
> Cc: stable@dpdk.org
> Signed-off-by: Kobi Kenzi <kobikenzi@gmail.com>
> ---
>  .mailmap                 | 1 +
>  doc/guides/nics/cnxk.rst | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index fcb3d1bb3f..f44296a218 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -887,6 +887,7 @@ Kiran Vedere <kiranv@nvidia.com>
>  Kirill Rybalchenko <kirill.rybalchenko@intel.com>
>  Kishore Padmanabha <kishore.padmanabha@broadcom.com>
>  Klaus Degner <kd@allegro-packets.com>
> +Kobi Kenzi <kobikenzi@gmail.com>
>  Kommula Shiva Shankar <kshankar@marvell.com>
>  Konstantin Ananyev <konstantin.ananyev@huawei.com> <konstantin.v.ananyev=
@yandex.ru>
>  Konstantin Ananyev <konstantin.ananyev@huawei.com> <konstantin.ananyev@i=
ntel.com>
> diff --git a/doc/guides/nics/cnxk.rst b/doc/guides/nics/cnxk.rst
> index cb7a86e8fc..56ad9dc7cf 100644
> --- a/doc/guides/nics/cnxk.rst
> +++ b/doc/guides/nics/cnxk.rst
> @@ -409,7 +409,7 @@ Runtime Config Options
>     When transmit completion handler is enabled,
>     the PMD invokes the callback handler provided by the application
>     for every packet which has external buf attached to mbuf
> -   and frees main mbuf, external buffer is provided to applicatoin.
> +   and frees main mbuf, external buffer is provided to application.
>     Once external buffer is handed over to application,
>     it is application responsibility either to free or reuse external buf=
fer
>     using ``tx_compl_ena`` devargs parameter.
> --
> 2.43.0
>
