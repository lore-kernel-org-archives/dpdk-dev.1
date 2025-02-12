Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF99AC02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 08:00:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FA4B40269;
	Wed, 12 Feb 2025 09:00:14 +0100 (CET)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by mails.dpdk.org (Postfix) with ESMTP id 0647840263;
 Wed, 12 Feb 2025 09:00:13 +0100 (CET)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-30761be8fcfso65837411fa.0; 
 Wed, 12 Feb 2025 00:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739347211; x=1739952011; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oBC5R4MzjOXQqifoW4Hkza1sJG2a6FXg1hYU8obnTiE=;
 b=DMidyvlQbVUkmXdw+tshmWUuMOJhItLZYX5uppZD2+FVXicoJ840m2VIChVkU71t6E
 EwIjj5kVLKx9WoueR/mo3m6sua2ElKYgStlZbz305idfPGr59SB4+Er5zI213J7lAL8/
 ILUOp4hZl/0/IxgXJ+GHBir4mPjmYoE1X1fBwmpDDNtLnvpo8kIg4byRZyRvtfxOIDab
 lfGN+p0QQKoaNy1cXI69/VGUnNA9C9pYVos/kgrZRlvXWkWJvuxp5j7WHBpQeYbmiIkY
 MfA+MjYF6TKYYinPWQhj25wI7MRdTy9GqWupbe+pPSbRwKKlQ2h+YcrK/SV5REsaLSWz
 TO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739347211; x=1739952011;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oBC5R4MzjOXQqifoW4Hkza1sJG2a6FXg1hYU8obnTiE=;
 b=FggF3nbGs6j1EE6VxjCBHDqOhKZXjiYb+PlD0zQ5ULRCh5GXgAu0wUnPuYaapUUsR8
 U4+2swekj8HfXnFbSklNOFk4DlRj7HicE9LzGYKx2ajXUpHP2vddKVrKnZkSyV/dnKlY
 77M2nyPPJ2XMuWq+FmM3lLYdT+IFhVOYvn9eOTq81OMDD7aThdNDVbzFYq12Q+75BoPq
 H/vYpWxqxp99vZMTTmvD5hFxZ9VPUaKronD5tnAoUinp5S+7XPwyKccvVpKLEyoMG+C+
 bzNXUVjqK26ApDNebtBRktIJRT4qTdLzyg3LMq9j3ivxiusiG5PiCNV7cvcwAzEj4U/V
 nMCA==
X-Gm-Message-State: AOJu0YyrJK/TrAaXjWeRrWhk6FyxRTdU2iPgvJs7BpviBHt70jJUkGtm
 3laJP/0iXO1KiE8o9MxMs7nmvmkKow+P5VJgKtyq80bmoDSi+vKzPWfV+bv+3oU07OS0S2m/JKc
 8UAcQPFZ/rcJMVWvOpI2vU7ToGhtqqA==
X-Gm-Gg: ASbGncvNKupfiqPjqo0YOzZLUZ2m8uXo6U+bgKxHoepn5CJuuxOu5Qmykedc28HNfg5
 afiq7rDwlYh11Sr+1EXD7kHv2YLWgfoSRWJ4iZc2a9nzELFXeKE9yhffURzCQ/II/etZJeQl8OQ
 ==
X-Google-Smtp-Source: AGHT+IEwC2Mhj5j3dIoxnWU740zpkGlQxLPoxgkmi0V/MdOHZYQCQoD9kgX0pSpPhX+16pGtqgZPu/SWDJYTIaF/8es=
X-Received: by 2002:a05:651c:198d:b0:308:e521:592 with SMTP id
 38308e7fff4ca-309036d380amr8916091fa.30.1739347210589; Wed, 12 Feb 2025
 00:00:10 -0800 (PST)
MIME-Version: 1.0
References: <bug-1562-3@http.bugs.dpdk.org/>
 <bug-1562-3-P2fNaCPFLO@http.bugs.dpdk.org/>
In-Reply-To: <bug-1562-3-P2fNaCPFLO@http.bugs.dpdk.org/>
From: Navin Srinivas <g.navinsrinivas@gmail.com>
Date: Wed, 12 Feb 2025 13:29:57 +0530
X-Gm-Features: AWEUYZl5pwJu7b3DipZvFs2JQiXASy1MrvoOW2B5YZszDaIdMpkHKABQpYKzKC4
Message-ID: <CACOt6jyPUfBPaX7t4rYde8dTgn9-we38s7WYFrrYx0iOyOC7FQ@mail.gmail.com>
Subject: Re: [DPDK/other Bug 1562] dumpcap captures all available network
 interfaces when specifying any PCI network interface
To: bugzilla@dpdk.org
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000a0f04c062ded5414"
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

--000000000000a0f04c062ded5414
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Is this backported to 22.11.1?

Thanks,
Navn Srinivas

On Thu, Oct 24, 2024 at 3:10=E2=80=AFPM <bugzilla@dpdk.org> wrote:

> Kevin Traynor <ktraynor@redhat.com> changed bug 1562
> <https://bugs.dpdk.org/show_bug.cgi?id=3D1562>
> What Removed Added
> Resolution --- WONTFIX
> Status UNCONFIRMED RESOLVED
>
> *Comment # 4 <https://bugs.dpdk.org/show_bug.cgi?id=3D1562#c4> on bug 156=
2
> <https://bugs.dpdk.org/show_bug.cgi?id=3D1562> from Kevin Traynor
> <ktraynor@redhat.com> *
>
> Thanks for reporting. It is fixed in main branch, but Stephen says it is =
not
> worth to backport to older releases. If it is important for you and you w=
ant to
> send a patch for 22.11 and 23.11 branches, it could be accepted.
>
>
> ------------------------------
> You are receiving this mail because:
>
>    - You are the assignee for the bug.
>
>

--000000000000a0f04c062ded5414
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div>Is this backported to 22.11.1=
?=C2=A0<div><br></div><div>Thanks,</div><div>Navn Srinivas</div></div><br><=
div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"g=
mail_attr">On Thu, Oct 24, 2024 at 3:10=E2=80=AFPM &lt;<a href=3D"mailto:bu=
gzilla@dpdk.org">bugzilla@dpdk.org</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
   =20
     =20
   =20
    <div><span><a href=3D"mailto:ktraynor@redhat.com" title=3D"Kevin Trayno=
r (ktraynor@redhat.com)" target=3D"_blank"> <span>Kevin Traynor</span></a>
</span> changed
          <a title=3D"RESOLVED WONTFIX - dumpcap captures all available net=
work interfaces when specifying any PCI network interface" href=3D"https://=
bugs.dpdk.org/show_bug.cgi?id=3D1562" target=3D"_blank">bug 1562</a>
          <br>
             <table border=3D"1" cellspacing=3D"0" cellpadding=3D"8">
          <tbody><tr>
            <th>What</th>
            <th>Removed</th>
            <th>Added</th>
          </tr>

         <tr>
           <td style=3D"text-align:right">Resolution</td>
           <td>---
           </td>
           <td>WONTFIX
           </td>
         </tr>

         <tr>
           <td style=3D"text-align:right">Status</td>
           <td>UNCONFIRMED
           </td>
           <td>RESOLVED
           </td>
         </tr></tbody></table>
      <p>
        </p><div>
            <b><a title=3D"RESOLVED WONTFIX - dumpcap captures all availabl=
e network interfaces when specifying any PCI network interface" href=3D"htt=
ps://bugs.dpdk.org/show_bug.cgi?id=3D1562#c4" target=3D"_blank">Comment # 4=
</a>
              on <a title=3D"RESOLVED WONTFIX - dumpcap captures all availa=
ble network interfaces when specifying any PCI network interface" href=3D"h=
ttps://bugs.dpdk.org/show_bug.cgi?id=3D1562" target=3D"_blank">bug 1562</a>
              from <span><a href=3D"mailto:ktraynor@redhat.com" title=3D"Ke=
vin Traynor (ktraynor@redhat.com)" target=3D"_blank"> <span>Kevin Traynor</=
span></a>
</span>
            </b>
          <pre>Thanks for reporting. It is fixed in main branch, but Stephe=
n says it is not
worth to backport to older releases. If it is important for you and you wan=
t to
send a patch for 22.11 and 23.11 branches, it could be accepted.
          </pre>
        </div>
      <p></p>


      <hr>
      <span>You are receiving this mail because:</span>

      <ul>
          <li>You are the assignee for the bug.</li>
      </ul>
      <div>
        <div>
         =20
         =20
         =20
        </div>
       =20
      </div>
    </div>
</blockquote></div>

--000000000000a0f04c062ded5414--
