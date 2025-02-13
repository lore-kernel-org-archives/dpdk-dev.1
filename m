Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF8DC0219D
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 11:18:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AD4A42ED0;
	Thu, 13 Feb 2025 12:18:04 +0100 (CET)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com
 [209.85.166.48]) by mails.dpdk.org (Postfix) with ESMTP id 7AAC342EA9
 for <dev@dpdk.org>; Thu, 13 Feb 2025 12:18:02 +0100 (CET)
Received: by mail-io1-f48.google.com with SMTP id
 ca18e2360f4ac-85525784a97so61445439f.0
 for <dev@dpdk.org>; Thu, 13 Feb 2025 03:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1739445482; x=1740050282; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8pe8tkkI1QEQ2gE61lkLoP/8mQ5GO8FOaQSGjtjJ480=;
 b=HtOrpDIaswxG1PwG2+KWgAyaT+oYF6FE/tHGmYg5JbWtb5Goq2yO2+XyxN7U4WDS1y
 Ny+wa5tRKanq1QCE4xyZJ8u98deDOixT6rK8tvf/ad8cfEjQJArjzPKH+3QiymLMSnSE
 Edsnd4ZaH51Ggoc0CfM27P3pUSrCuswcIcC2Zwvvvqv9pFYchRHV6lDVWXvtME+C3VT5
 fXT2Y0BWTs9+vs9439u4UmfZPh99ljobbLRbKXHqv1ct3cGZYnba0KKB2kY86f7rpoJE
 gyMj4DP2hUpKKMTmvPfF8gRXaLekUyWmj15OOH1OK/3NeZODw0CEAZlenxT21i7IkVRp
 NVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739445482; x=1740050282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8pe8tkkI1QEQ2gE61lkLoP/8mQ5GO8FOaQSGjtjJ480=;
 b=ISPDfP1zQRZW2mo4Au4gNJd/3Zm0UI5l21f+u6wF04NPAxkEFOnFR2g84Bhb/p0iqV
 0EqQ6GlaAW/sg2j9mYGsB/zpqzNtd2t7Q0ntOb0ZwicfVtBZKCvWoHgwqh2Og79wJdVO
 wYpc3V2PoEpZCmBnjazUH5lSOxJgkCcaMdhPnL8UVP8EA07eifxDs5c/l0SNApm2GvhT
 E7Axc0shRwlT4UoQTi9Tn/KojtF/4ouI2aosmQEDU4/4tt8CZruUemT0x3DaWWVkNUKj
 mJbX6fYr1zWoVrmlx2nfHc9n4mO8wQkZfdmLRThkO2G3QwLgKvVFLhhqL7IktWMPO60C
 5TYQ==
X-Gm-Message-State: AOJu0Yx/6NHeXz/Uc063YR6iKrFov+XbhEqNidQcw/udePbzXo68pn9F
 R5HQeVUTwpDMnVzdyXbR3AKk39K39HxB3Es3YKuKXyqD15/4Uc2OURKdqFq2ZOMrGGEyMbPUIO7
 CyItQO+/Yqmrmpmik5cW8rT0CSsHWkY4xjnN7hQ==
X-Gm-Gg: ASbGncuqbKWYYRucZEvgLSwKdtL9EWHgBRPel/2C41A3RSMNXDdxo3RBVL63BW3ODYu
 lA/7p0bhDl5VcvdQkObwIJcTHeyHMlSj1/bTNu4Stk8dWr7fEUBeFv2oMLzfQGAy6sLXh6FM=
X-Google-Smtp-Source: AGHT+IFqwNSBOHeK2f+K5nD0CiIbst8oGvOZyhGn4zYSFASOcviGSILxnfTqAqgYAsZ9N4oh9VXgiT9Ts6r8Joy1uC0=
X-Received: by 2002:a05:6e02:12c2:b0:3d0:25d0:8507 with SMTP id
 e9e14a558f8ab-3d18c22b0fbmr26588345ab.6.1739445481711; Thu, 13 Feb 2025
 03:18:01 -0800 (PST)
MIME-Version: 1.0
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250207104552.1663519-1-ariel.otilibili@6wind.com>
 <20250207104552.1663519-3-ariel.otilibili@6wind.com>
 <2b6e60c0-4436-44dd-bba2-335c1b22a7e9@redhat.com>
 <CAF1zDgYZJLX7FBCpwMWrfiLm6si-8jpfppQaW1Cd36QoNOCOfw@mail.gmail.com>
In-Reply-To: <CAF1zDgYZJLX7FBCpwMWrfiLm6si-8jpfppQaW1Cd36QoNOCOfw@mail.gmail.com>
From: Ariel Otilibili <ariel.otilibili@6wind.com>
Date: Thu, 13 Feb 2025 12:17:51 +0100
X-Gm-Features: AWEUYZkaXK6YeVBD5TCpZRUtDJKxhnoysUJ5uCpWylHnJAXbyGn6cRcn5TbxZVk
Message-ID: <CAF1zDgatvhGqZBYf0K=RkVJQvDxo+==WWDAAXREqHAuR15W-2Q@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] net/af_xdp: Refactor af_xdp_tx_zc
To: Maryam Tahhan <mtahhan@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>, 
 Ciara Loftus <ciara.loftus@intel.com>
Content-Type: multipart/alternative; boundary="0000000000000b3e86062e0436bd"
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

--0000000000000b3e86062e0436bd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Maryam, hello Stephen;

On Fri, Feb 7, 2025 at 1:33=E2=80=AFPM Ariel Otilibili <ariel.otilibili@6wi=
nd.com>
wrote:

>
>
> On Fri, Feb 7, 2025 at 12:13=E2=80=AFPM Maryam Tahhan <mtahhan@redhat.com=
> wrote:
>
>>
>> On 07/02/2025 10:45, Ariel Otilibili wrote:
>>
>> Both legs of the loop share the same logic: the common parts are about
>> reserving and filling both address and length into the description.
>>
>> This is moved into reserve_and_fill().
>>
>> Bugzilla ID: 1440
>> Suggested-by: Maryam Tahhan <mtahhan@redhat.com> <mtahhan@redhat.com>
>> Signed-off-by: Ariel Otilibili <ariel.otilibili@6wind.com> <ariel.otilib=
ili@6wind.com>
>>
>> Acked-by: Maryam Tahhan <mtahhan@redhat.com> <mtahhan@redhat.com>
>>
>>
> Thanks for your insight, Maryam; I've learnt a lot along the way.
>

Are you expecting anything from me? From what I understood, the series was
acked. Still, patchwork labels it as* Change Requested.*

http://patches.dpdk.org/project/dpdk/patch/20250207104552.1663519-3-ariel.o=
tilibili@6wind.com/

Let me know,
Ariel

--0000000000000b3e86062e0436bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hello Maryam, hello Stephen;</div></=
div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Fri, Feb 7, 2025 at 1:33=E2=80=AFPM Ariel Otilibili =
&lt;<a href=3D"mailto:ariel.otilibili@6wind.com">ariel.otilibili@6wind.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 7, 2025 at 12:13=E2=80=AFP=
M Maryam Tahhan &lt;<a href=3D"mailto:mtahhan@redhat.com" target=3D"_blank"=
>mtahhan@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><u></u>

 =20
   =20
 =20
  <div>
    <p><br>
    </p>
    <div>On 07/02/2025 10:45, Ariel Otilibili
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
      <pre>Both legs of the loop share the same logic: the common parts are=
 about
reserving and filling both address and length into the description.

This is moved into reserve_and_fill().

Bugzilla ID: 1440
Suggested-by: Maryam Tahhan <a href=3D"mailto:mtahhan@redhat.com" target=3D=
"_blank">&lt;mtahhan@redhat.com&gt;</a>
Signed-off-by: Ariel Otilibili <a href=3D"mailto:ariel.otilibili@6wind.com"=
 target=3D"_blank">&lt;ariel.otilibili@6wind.com&gt;</a>
</pre>
    </blockquote>
    <pre>Acked-by: Maryam Tahhan <a href=3D"mailto:mtahhan@redhat.com" targ=
et=3D"_blank">&lt;mtahhan@redhat.com&gt;</a></pre></div></blockquote><div><=
br></div><div>Thanks for your insight, Maryam; I&#39;ve learnt a lot along =
the way. <br></div></div></div></blockquote><div><br></div><div><div>Are yo=
u expecting anything from me? From what I understood, the series was acked.=
 Still, patchwork labels it as<i> Change Requested.</i></div><div><br></div=
><div><a href=3D"http://patches.dpdk.org/project/dpdk/patch/20250207104552.=
1663519-3-ariel.otilibili@6wind.com/">http://patches.dpdk.org/project/dpdk/=
patch/20250207104552.1663519-3-ariel.otilibili@6wind.com/</a></div><div><br=
></div><div>Let me know,</div><div>Ariel<br></div></div></div></div>

--0000000000000b3e86062e0436bd--
