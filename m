Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E304DEED626
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Jan 2026 17:43:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADC6340267;
	Thu,  1 Jan 2026 18:43:15 +0100 (CET)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53]) by mails.dpdk.org (Postfix) with ESMTP id 47A7040262
 for <dev@dpdk.org>; Thu,  1 Jan 2026 18:43:14 +0100 (CET)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-7c7aee74dceso4513087a34.2
 for <dev@dpdk.org>; Thu, 01 Jan 2026 09:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767289393; x=1767894193; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z1KPrbZkeJravhqXr5etlOZIy+Y+YVyp19bUIcMGK94=;
 b=I3BozKd+3RhMd3ehJp5UaS4nxC/Sw9rNf0Phh1+SCfjePG/MuxVqXjo5KMcXGkj1t9
 xscNR9i1oSIhz2ylIHJgmGl/UDURC5Y069P0OofaAQXawd1yQ8scTs9Lqnf8LI1KSlEs
 NGOnGZsY8IsqIejlpgwbSir7N9ZlMDtZttIgWtRCe5s8h8UWiEnFEUIdKE4C0I3Ble4I
 ejobcMc9uZ6awKVHJ5de+G37rr4qvBDsFjlFj+19zo6h4LH0U+rqmnI8okZ0HXZ/AYak
 pmjBAXUIXpAa7erwmVjuuQDvr0SmO4qow4lxyxj1T54+LVcVso3KW2NMbdDtqQK6gD6m
 Dy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767289393; x=1767894193;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z1KPrbZkeJravhqXr5etlOZIy+Y+YVyp19bUIcMGK94=;
 b=Tki6Fw6f8zlKu0B1ec7q2VklhL0sU4pNPTZCYQUAz4MH5m0QbJOXLINFS2VKa0GHSO
 DxfPDDp428AzQcsDa90IQHHtPk5TMOuwZeIbjK+f+G3BrljtmGGoG9TnZOfaXkG4qsh4
 /e0WlYvlDUcPyUFP+PpylfNWngOqkmth4nh7S0icKYIFCLek0IriNx8OPk+aTXCMOUEp
 WM4+4buMFbvYK81W2MmlJo3+C70Z31xeusKv5V1IH0cEj7l7NN3j7qK+mc26QQlxo1yi
 lrY0L7IorgMBJ4dXWuTLvrnKPstdsavvUniMC7LPo+DuWYlPknm3j1lQyFVQGE5FTT+F
 Q2AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3d0PpZCOMOfobdosncGjBxJbwWgZ9zdTzaaQBbayyKNWgtAXiEaNmY44YYKOwe4CnhBA=@dpdk.org
X-Gm-Message-State: AOJu0Yz2bUQYgd3upP0p+9J+O3YzwdVHGA2Lm/Yp+3bkI/J/o1fv5XN1
 7CfXfP8meNtrOiyZsh4CiEDvF4j5qJOjXT6fvp5xTQPEW90oqiYTVby4yK7aG8eRMGdqKiTmzDw
 kkI5g7ljqk9qmdA7oQ6my61SJsZSPdkU=
X-Gm-Gg: AY/fxX70tBygJ4LbCA3AgAtPq7ZvJZafW+JPC0pRCrqA4guQgf5C9HbSLtQcgbbxnnW
 6hOTQKnENWIYX1yZUuqyUjHdKeC8sV16mOeOnkGsEipwO3vY5gOantCzV6+bKtyYbPBEN+xDWD/
 sNbWD6B2pEev7IhvKvjJjpUZ5KWK1WY2I3FuxWfavQE/TP7wJkjEJQFuOfzHaetvhrRMBWgKy7+
 SIHWifAT7qFeUkMWoc5AF+H4m9tlY8DptDD6sV2y9fnQZ2Mlb4SSUD4kLlz5JWgfXBsWbYCb2xp
 FuskoqS8/enSuWEGkQ+JWaZ1EX+v6A==
X-Google-Smtp-Source: AGHT+IGYuXKruBfptWa0V2SEYn5JdDDQt/n9sUBXR1iF29qmyB3cNfV/CMq4MeKREOFTPuwnT3e3iZq1NNeHg8EWY3Q=
X-Received: by 2002:a4a:d143:0:b0:659:9a49:8e69 with SMTP id
 006d021491bc7-65d0eae197fmr12352027eaf.57.1767289393199; Thu, 01 Jan 2026
 09:43:13 -0800 (PST)
MIME-Version: 1.0
References: <20251212115238.59710-1-madhukar.mythri@gmail.com>
 <DS3PR21MB5735BCEBB4C726C7E0B7AC4DCEA9A@DS3PR21MB5735.namprd21.prod.outlook.com>
 <20251220102503.54d04c5d@phoenix.local>
 <CAAUNki3mxT3TZNxmiyLYU6zsjXdvCj6ZxCX9QU8Nh7JQ2HV5wA@mail.gmail.com>
 <EA3PR21MB5743C76495BAA587CAA14C0DCEBDA@EA3PR21MB5743.namprd21.prod.outlook.com>
In-Reply-To: <EA3PR21MB5743C76495BAA587CAA14C0DCEBDA@EA3PR21MB5743.namprd21.prod.outlook.com>
From: madhukar mythri <madhukar.mythri@gmail.com>
Date: Thu, 1 Jan 2026 23:13:02 +0530
X-Gm-Features: AQt7F2r65F68FXN_1WegrDPaVJJqUmYL7RPZMx-zt8Y0slr1pu6TsPi8E6XbK5M
Message-ID: <CAAUNki2RCAGFw3-FG6=G0ZnaHRJ_pqnN3etFJYc0cePpZF01ww@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH] net/netvsc: Fix on race condition of multiple
 commands
To: Long Li <longli@microsoft.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 "dev@dpdk.org" <dev@dpdk.org>, 
 Madhuker Mythri <madhuker.mythri@oracle.com>
Content-Type: multipart/alternative; boundary="0000000000007f3ffa06475720a5"
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

--0000000000007f3ffa06475720a5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Long,

Yes, got it.
By caching the results of 'hn_rndis_query_hwcaps()' inside PMD will be
better.
Yes, you can submit the patch 'Or' let me know, if you are busy.

Thanks,
Madhukar.

On Thu, Jan 1, 2026 at 4:52=E2=80=AFAM Long Li <longli@microsoft.com> wrote=
:

> Hi Madhukar,
>
>
>
> I suggest caching the result of hn_rndis_query_hwcaps(), as suggested by
> Stephen. This can be done inside PMD. Do you want me to submit a patch?
>
>
>
> For querying link status, the lock should be implemented inside
> hn_rndis_exec1(). The drawback is that this function can potentially wait
> for up to 60 seconds on response from host, maybe not suitable for spinlo=
ck
> in production use. But I think it=E2=80=99s better to have application re=
try on
> BUSY (with some delay logic), as the netvsc is designed in this way since
> introduced.
>
>
>
> Thanks,
>
> Long
>
>
>
>
>
>
>
> *From:* madhukar mythri <madhukar.mythri@gmail.com>
> *Sent:* Saturday, December 20, 2025 9:37 PM
> *To:* Stephen Hemminger <stephen@networkplumber.org>
> *Cc:* Long Li <longli@microsoft.com>; dev@dpdk.org; Madhuker Mythri <
> madhuker.mythri@oracle.com>
> *Subject:* Re: [EXTERNAL] [PATCH] net/netvsc: Fix on race condition of
> multiple commands
>
>
>
> You don't often get email from madhukar.mythri@gmail.com. Learn why this
> is important <https://aka.ms/LearnAboutSenderIdentification>
>
> Hi Li and Stephen,
>
>
>
> We have a common DPDK application for all the PMD's, in which we are
> seeing issue for this Netvsc PMD only.
>
> I mean, for KVM hypervisor with Intel or Mellanox NICs we did not see suc=
h
> sync issues. Also, with failsafe PMD on hyper-v did not seen such sync
> issues.
>
>
>
> So, i thought this would be better to fix at PMD level using spinlock.
>
>
>
> @Stephen Hemminger <stephen@networkplumber.org> , yes we can store the
> device info get details after probe and reuse it later.
>
> For Link-status get with multiple threads we can go with retry mechanism.
>
>
>
> However, w.r.t all other PMD's this device info get and Link-status get
> has issues in multi threaded application.
>
>
>
> Regards,
>
> Madhuker.
>
>
>
> On Sat, 20 Dec, 2025, 23:55 Stephen Hemminger, <stephen@networkplumber.or=
g>
> wrote:
>
> On Fri, 19 Dec 2025 17:35:33 +0000
> Long Li <longli@microsoft.com> wrote:
>
> > > When multiple processes issue command requests(like: device info get
> and
> > > link-status) at same-time, then we could see the command request
> failures,
> > > due to race-condition of common function execution.
> >
> > Hi Madhuker,
> >
> > I'm not sure if we should use a lock in the driver for this. It's not
> clear in DPDK documents but in general the calls to query device status a=
re
> not thread safe.
> >
> > Is it possible that the application uses a lock to sync calling to this=
?
> >
>
> I do not know of any restrictions about threads calling query operations.
>
> For info_get() the transaction is in rndis_get_offload().
> There are couple of ways to handle this better. One would to do
> the query during probe and remember the result. The hypervisor is
> not going to change supported offload. The other and simpler way
> would be to just have hardcoded offload values. The code for query
> got compute offloads is inherited for BSD and unless someone was trying
> to run on Windows 2012 or earlier version of Hyper-V it would never chang=
e.
>
> Link status is a little more complex. Does the hyper-visor ever report
> that the software path is down? And reading through the hn_rdis_exec code
> it looks like if multiple operations are in process the second one
> should return -EBUSY. Application could retry in that case.
>
>

--0000000000007f3ffa06475720a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Long,<div><br></div><div>Yes, got it.</div><div>By cach=
ing the results of &#39;hn_rndis_query_hwcaps()&#39; inside PMD will be bet=
ter.</div><div>Yes, you can submit the patch &#39;Or&#39; let me know, if y=
ou are busy.</div><div><br></div><div>Thanks,</div><div>Madhukar.</div></di=
v><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Thu, Jan 1, 2026 at 4:52=E2=80=AFAM Long Li &lt;<a hre=
f=3D"mailto:longli@microsoft.com">longli@microsoft.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><div class=3D"msg1208=
458461010019189">





<div lang=3D"EN-US" style=3D"overflow-wrap: break-word;">
<div class=3D"m_1208458461010019189WordSection1">
<p class=3D"MsoNormal">Hi Madhukar,<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">I suggest caching the result of hn_rndis_query_hwcap=
s(), as suggested by Stephen. This can be done inside PMD. Do you want me t=
o submit a patch?<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">For querying link status, the lock should be impleme=
nted inside hn_rndis_exec1(). The drawback is that this function can potent=
ially wait for up to 60 seconds on response from host, maybe not suitable f=
or spinlock in production use. But
 I think it=E2=80=99s better to have application retry on BUSY (with some d=
elay logic), as the netvsc is designed in this way since introduced.<u></u>=
<u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Thanks,<u></u><u></u></p>
<p class=3D"MsoNormal">Long<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div style=3D"border-top:none;border-right:none;border-bottom:none;border-l=
eft:1.5pt solid blue;padding:0in 0in 0in 4pt">
<div>
<div style=3D"border-right:none;border-bottom:none;border-left:none;border-=
top:1pt solid rgb(225,225,225);padding:3pt 0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11pt;font-family:Calibri=
,sans-serif">From:</span></b><span style=3D"font-size:11pt;font-family:Cali=
bri,sans-serif"> madhukar mythri &lt;<a href=3D"mailto:madhukar.mythri@gmai=
l.com" target=3D"_blank">madhukar.mythri@gmail.com</a>&gt;
<br>
<b>Sent:</b> Saturday, December 20, 2025 9:37 PM<br>
<b>To:</b> Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.o=
rg" target=3D"_blank">stephen@networkplumber.org</a>&gt;<br>
<b>Cc:</b> Long Li &lt;<a href=3D"mailto:longli@microsoft.com" target=3D"_b=
lank">longli@microsoft.com</a>&gt;; <a href=3D"mailto:dev@dpdk.org" target=
=3D"_blank">dev@dpdk.org</a>; Madhuker Mythri &lt;<a href=3D"mailto:madhuke=
r.mythri@oracle.com" target=3D"_blank">madhuker.mythri@oracle.com</a>&gt;<b=
r>
<b>Subject:</b> Re: [EXTERNAL] [PATCH] net/netvsc: Fix on race condition of=
 multiple commands<u></u><u></u></span></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<table border=3D"0" cellspacing=3D"0" cellpadding=3D"0" align=3D"left" widt=
h=3D"100%" style=3D"width:100%">
<tbody>
<tr>
<td width=3D"0" style=3D"width:0.3pt;background:rgb(166,166,166);padding:5.=
25pt 1.5pt">
</td>
<td width=3D"100%" style=3D"background:revert;border:revert;color:revert;di=
rection:revert;display:revert;font-size:revert;height:revert;letter-spacing=
:revert;line-height:revert;margin:revert;opacity:revert;outline:revert;over=
flow:revert;padding:revert;table-layout:revert;text-align:revert;text-inden=
t:revert;text-orientation:revert;text-overflow:revert;text-transform:revert=
;vertical-align:revert;white-space:revert;width:revert;word-break:revert;wo=
rd-spacing:revert;writing-mode:revert;zoom:revert">
<div>
<p class=3D"MsoNormal">
<span style=3D"font-size:9pt;font-family:&quot;Segoe UI&quot;,sans-serif;co=
lor:rgb(33,33,33)">You don&#39;t often get email from
</span><span style=3D"color:black"><a href=3D"mailto:madhukar.mythri@gmail.=
com" target=3D"_blank"><span style=3D"font-size:9pt;font-family:&quot;Segoe=
 UI&quot;,sans-serif">madhukar.mythri@gmail.com</span></a></span><span styl=
e=3D"font-size:9pt;font-family:&quot;Segoe UI&quot;,sans-serif;color:rgb(33=
,33,33)">.
</span><span style=3D"color:black"><a href=3D"https://aka.ms/LearnAboutSend=
erIdentification" target=3D"_blank"><span style=3D"font-size:9pt;font-famil=
y:&quot;Segoe UI&quot;,sans-serif">Learn why this is important</span></a></=
span><span style=3D"font-size:9pt;font-family:&quot;Segoe UI&quot;,sans-ser=
if;color:rgb(33,33,33)">
<u></u><u></u></span></p>
</div>
</td>
<td width=3D"75" style=3D"background:revert;border:revert;color:revert;dire=
ction:revert;display:revert;font-size:revert;height:revert;letter-spacing:r=
evert;line-height:revert;margin:revert;opacity:revert;outline:revert;overfl=
ow:revert;padding:revert;table-layout:revert;text-align:revert;text-indent:=
revert;text-orientation:revert;text-overflow:revert;text-transform:revert;v=
ertical-align:revert;white-space:revert;width:revert;word-break:revert;word=
-spacing:revert;writing-mode:revert;zoom:revert">
</td>
</tr>
</tbody>
</table>
<div>
<div>
<p class=3D"MsoNormal">Hi Li and Stephen, <u></u><u></u></p>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">We have a common DPDK application for all the PMD&#3=
9;s, in which we are seeing issue for this Netvsc PMD only.<u></u><u></u></=
p>
</div>
<div>
<p class=3D"MsoNormal">I mean, for KVM hypervisor with Intel or Mellanox NI=
Cs we did not see such sync issues. Also, with failsafe PMD on hyper-v did =
not seen such sync issues.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">So, i thought this would be better to fix at PMD lev=
el using spinlock.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><a href=3D"mailto:stephen@networkplumber.org" target=
=3D"_blank"><span style=3D"color:rgb(17,85,204)">@Stephen Hemminger</span><=
/a>=C2=A0, yes we can store the device info get details after probe and reu=
se it later.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">For Link-status get with multiple threads we can go =
with retry mechanism.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">However, w.r.t all other PMD&#39;s this device info =
get and Link-status get has issues in multi threaded application.<u></u><u>=
</u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Regards,<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Madhuker.<u></u><u></u></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">On Sat, 20 Dec, 2025, 23:55 Stephen Hemminger, &lt;<=
a href=3D"mailto:stephen@networkplumber.org" target=3D"_blank">stephen@netw=
orkplumber.org</a>&gt; wrote:<u></u><u></u></p>
</div>
<blockquote style=3D"border-top:none;border-right:none;border-bottom:none;b=
order-left:1pt solid rgb(204,204,204);padding:0in 0in 0in 6pt;margin:5pt 0i=
n 5pt 4.8pt">
<p class=3D"MsoNormal">On Fri, 19 Dec 2025 17:35:33 +0000<br>
Long Li &lt;<a href=3D"mailto:longli@microsoft.com" target=3D"_blank">longl=
i@microsoft.com</a>&gt; wrote:<br>
<br>
&gt; &gt; When multiple processes issue command requests(like: device info =
get and<br>
&gt; &gt; link-status) at same-time, then we could see the command request =
failures,<br>
&gt; &gt; due to race-condition of common function execution.=C2=A0 <br>
&gt; <br>
&gt; Hi Madhuker,<br>
&gt; <br>
&gt; I&#39;m not sure if we should use a lock in the driver for this. It&#3=
9;s not clear in DPDK documents but in general the calls to query device st=
atus are not thread safe.<br>
&gt; <br>
&gt; Is it possible that the application uses a lock to sync calling to thi=
s?<br>
&gt; <br>
<br>
I do not know of any restrictions about threads calling query operations.<b=
r>
<br>
For info_get() the transaction is in rndis_get_offload().<br>
There are couple of ways to handle this better. One would to do<br>
the query during probe and remember the result. The hypervisor is<br>
not going to change supported offload. The other and simpler way<br>
would be to just have hardcoded offload values. The code for query<br>
got compute offloads is inherited for BSD and unless someone was trying<br>
to run on Windows 2012 or earlier version of Hyper-V it would never change.=
<br>
<br>
Link status is a little more complex. Does the hyper-visor ever report<br>
that the software path is down? And reading through the hn_rdis_exec code<b=
r>
it looks like if multiple operations are in process the second one<br>
should return -EBUSY. Application could retry in that case.<u></u><u></u></=
p>
</blockquote>
</div>
</div>
</div>
</div>
</div>

</div></blockquote></div>

--0000000000007f3ffa06475720a5--
