Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992D4C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 19:30:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F9AE40281;
	Tue, 22 Jul 2025 21:30:18 +0200 (CEST)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51]) by mails.dpdk.org (Postfix) with ESMTP id D8D264003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 21:30:16 +0200 (CEST)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-6fad3400ea3so54562196d6.0
 for <dev@dpdk.org>; Tue, 22 Jul 2025 12:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753212616;
 x=1753817416; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QYZuKYmr1PLwtfPThmzJHGA9asZ4PU077WEt42CrZwA=;
 b=CKu7ztNOJ1MfR67EJaFOzfL/2HNpE9S9pL45eOCEr+zjgCz9QY4T3wn/jU6WREbGpt
 7elaONfgmEKAAEMQ3qy5dSCTf6HdeVfqXdkCpjzt9hAlhQ1G8k+32QaQtnEA4f8aIXxv
 NYifPvTpFLFSqZZQq1kZwq06Av0sxjLdSstP0y7EyQb0ggO9/K8Dk9F5hJXwiBU5/XXK
 MUtKDH6T/SldOAdJhHzGaCMc+3XuyTqz5/n4v1VTqUNO4wyOYfilBKzi5o7xOgP6jQK9
 Ed7zbckdDTrshSIaT4jdXJUo4OG4uAtPv5jig1M3YBb1G2FcGjjLevOjDK+97uABSQcu
 8MTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753212616; x=1753817416;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QYZuKYmr1PLwtfPThmzJHGA9asZ4PU077WEt42CrZwA=;
 b=sZ3YcmJRqtlTCJHs9HYx3BsGzJYsu3m6tGuzzpyuiNyIq37l9Od7FnAb9JRrwHNjMC
 gEPMGbxb41509q3uodCDrsqEP4cmT7yISWJPLzJ+IumeiA/wlmdbciPqMXAT7vJNes7h
 /6dRZRg3Llsg7lEniDd879fRdzxCJB/uZ3F5vN40s4n8/BYBefGy4YeGgV1jvJSJ0Mme
 PNigSpHpgL/bKVdIhlmUxQp4jE7xnuyjQt/wRN6Hzv1SjBWp/g94gWSxV7ZQ2e5jx//K
 PCMB1O0jSdbPNYPiJSYj2LSSKzrEWi+Ro3JOE1ex9PfBiTpo5P2NxvJSTxnke3G7Ctyk
 MFBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV58D907f+Ghn2g5oHkxeQQghiBATv1z5aWYE6t/DWq4jekqb2XwVI3YGGfA92syegHqYM=@dpdk.org
X-Gm-Message-State: AOJu0Yx/RUkT1e8S8QAbca6ebt51p59sMzlbU5PyD8m9YydSDy7B4onR
 ryjRe4KnxGP9hC9Xo40OawawRjEPFDYafbW+PHrJia+BGeywOcAFClTofpDYmM9tZUPIW+hr2ao
 Aa2ojhy4om7zqBBxSDBuj1n2Qazcg/xpDlZRNcz9/Ng==
X-Gm-Gg: ASbGncutOqS8UtDHSxDIz95FPeN5n8EY0fhwDkAQ9rNofIEJj+a9F0DV6M+RcP9en68
 fuu5zuuZU/umTU/mFQTZIlUw3i5cMO3ybYe5rnKdvvIkg9lKB3tE38YsgRMeD6vNdcn5e4hZi4h
 MjIV08u83wbaNKJqPZOWP3glwlNI7d177uSktLxMmH6zRmExFIgT6Ulwrs8QX87OL3z2ev8LQSI
 98jHFLTfym8Z7TpGYY7f485PsOt9Mgasb1gOcBz
X-Google-Smtp-Source: AGHT+IGCVQvk5C5Kb1UKDjSqaU5ZRTey0Y5qmHfC7sFYxVCxGAG65ZBEtDo9n2alrKE/9Z+L6muGjOCpVoL6g0HJlJs=
X-Received: by 2002:a05:6214:21c3:b0:6fb:619c:98ac with SMTP id
 6a1803df08f44-70700739c76mr5540206d6.39.1753212615918; Tue, 22 Jul 2025
 12:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250721073851.963141-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250721105819.2ci66fl7bzikwb22@ds-vm-debian.local>
 <b0c702cc-1213-d773-0ee0-804542a07e28@arknetworks.am>
 <3358342.oiGErgHkdL@thomas>
In-Reply-To: <3358342.oiGErgHkdL@thomas>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Wed, 23 Jul 2025 00:30:03 +0500
X-Gm-Features: Ac12FXyKSQcd8lSRFyw_yD_XyuJkHbiXKVed90WCf0DrdGiBpoiQEPri1ynx89I
Message-ID: <CA++2-x6o1QXgO=RiWk8vFcCRfs3ZCWc5G-yoebxCzPVzAZY9Gg@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: fix crash when secondary queries dev info after
 primary exits
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Ivan Malov <ivan.malov@arknetworks.am>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org,
 rasland@nvidia.com, 
 dpdk stable <stable@dpdk.org>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, 
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Content-Type: multipart/alternative; boundary="000000000000301bc2063a899f62"
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

--000000000000301bc2063a899f62
Content-Type: text/plain; charset="UTF-8"

I think at least this should be followed either in PMD or in ethdev layer
to avoid this specific crashes.

On Mon, Jul 21, 2025, 17:00 Thomas Monjalon <thomas@monjalon.net> wrote:

> 21/07/2025 13:46, Ivan Malov:
> > On Mon, 21 Jul 2025, Dariusz Sosnowski wrote:
> >
> > > + mlx5 maintainers
> > >
> > > Thank you for the patch.
> > >
> > > Could you please include other PMD maintainers (or other maintainers,
> depending on changed code)
> > > in the future patches?
> > > There is a script which automatically adds maintainers while sending a
> patch.
> > > It is described in:
> https://doc.dpdk.org/guides/contributing/patches.html#sending-patches
> > >
> > > On Mon, Jul 21, 2025 at 03:38:51AM -0400, Khadem Ullah wrote:
> > >> When the primary process exits, the shared mlx5 state becomes
> > >> unavailable to secondary processes. If a secondary process attempts
> > >> to query device information (e.g., via testpmd), a NULL dereference
> > >> may occur due to missing shared data.
> > >>
> > >> This patch adds a check for shared context availability and fails
> > >> gracefully while preventing a crash.
> > >>
> > >> Fixes: e60fbd5b24fc ("mlx5: add device configure/start/stop")
> > >> Cc: stable@dpdk.org
> > >>
> > >> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> > >> ---
> > >>  drivers/net/mlx5/mlx5_ethdev.c | 6 ++++++
> > >>  1 file changed, 6 insertions(+)
> > >>
> > >> diff --git a/drivers/net/mlx5/mlx5_ethdev.c
> b/drivers/net/mlx5/mlx5_ethdev.c
> > >> index 68d1c1bfa7..1848f6536a 100644
> > >> --- a/drivers/net/mlx5/mlx5_ethdev.c
> > >> +++ b/drivers/net/mlx5/mlx5_ethdev.c
> > >> @@ -368,6 +368,12 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev,
> struct rte_eth_dev_info *info)
> > >>     * Since we need one CQ per QP, the limit is the minimum number
> > >>     * between the two values.
> > >>     */
> > >> +  if (priv == NULL || priv->sh == NULL) {
> > >> +          DRV_LOG(ERR,
> > >> +          "mlx5 shared data unavailable (primary process likely
> exited)");
> > >> +          rte_errno = ENODEV;
> > >> +          return -rte_errno;
> > >> +  }
> > >
> > > I don't think it's an issue on PMD level, but rather on
> > > ethdev/multi-process handling level.
> >
> > I may be very wrong here, but can't the PMD use its internal 'shared'
> state to
> > somehow memorise the fact that a secondary process has attached, in
> order to not
> > let the primary process close in the first place (before the secondary
> process
> > detaches)? Or is this going to violate some established convention?
>
> It looks to be a good idea.
>
> > > When primary process closes the port, ethdev library zeroes and frees
> > > device data shared between processes.
> > > ethdev port data (rte_eth_dev) on secondary is not updated so it now
> points to
> > > invalid data. rte_eth_dev_info_get() is not the only API call affected.
> > >
> > > If the primary process closes the port before exiting
> > > (like testpmd does) and it exits before the secondary,
> > > the any driver call seems invalid because of that use-after-free
> behavior.
> > >
> > > @Thomas, @Andrew - Do you happen to know if doing anything on ethdev
> ports
> > > in secondary process after primary has gracefully exited is supported?
>
> No there is no statement about whether it is supported or not.
> I think we should at least return an error instead of crashing.
>
>
>

--000000000000301bc2063a899f62
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I think at least this should be followed either in PMD or=
 in ethdev layer to avoid this specific crashes.=C2=A0</div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Mon, Jul 21, 2025, 17:00 Thomas Monjalon &lt;<a href=3D"mailto:thomas@=
monjalon.net">thomas@monjalon.net</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">21/07/2025 13:46, Ivan Malov:<br>
&gt; On Mon, 21 Jul 2025, Dariusz Sosnowski wrote:<br>
&gt; <br>
&gt; &gt; + mlx5 maintainers<br>
&gt; &gt;<br>
&gt; &gt; Thank you for the patch.<br>
&gt; &gt;<br>
&gt; &gt; Could you please include other PMD maintainers (or other maintain=
ers, depending on changed code)<br>
&gt; &gt; in the future patches?<br>
&gt; &gt; There is a script which automatically adds maintainers while send=
ing a patch.<br>
&gt; &gt; It is described in: <a href=3D"https://doc.dpdk.org/guides/contri=
buting/patches.html#sending-patches" rel=3D"noreferrer noreferrer" target=
=3D"_blank">https://doc.dpdk.org/guides/contributing/patches.html#sending-p=
atches</a><br>
&gt; &gt;<br>
&gt; &gt; On Mon, Jul 21, 2025 at 03:38:51AM -0400, Khadem Ullah wrote:<br>
&gt; &gt;&gt; When the primary process exits, the shared mlx5 state becomes=
<br>
&gt; &gt;&gt; unavailable to secondary processes. If a secondary process at=
tempts<br>
&gt; &gt;&gt; to query device information (e.g., via testpmd), a NULL deref=
erence<br>
&gt; &gt;&gt; may occur due to missing shared data.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This patch adds a check for shared context availability and f=
ails<br>
&gt; &gt;&gt; gracefully while preventing a crash.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Fixes: e60fbd5b24fc (&quot;mlx5: add device configure/start/s=
top&quot;)<br>
&gt; &gt;&gt; Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank" rel=
=3D"noreferrer">stable@dpdk.org</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Signed-off-by: Khadem Ullah &lt;<a href=3D"mailto:14pwcse1224=
@uetpeshawar.edu.pk" target=3D"_blank" rel=3D"noreferrer">14pwcse1224@uetpe=
shawar.edu.pk</a>&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt;=C2=A0 drivers/net/mlx5/mlx5_ethdev.c | 6 ++++++<br>
&gt; &gt;&gt;=C2=A0 1 file changed, 6 insertions(+)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx=
5/mlx5_ethdev.c<br>
&gt; &gt;&gt; index 68d1c1bfa7..1848f6536a 100644<br>
&gt; &gt;&gt; --- a/drivers/net/mlx5/mlx5_ethdev.c<br>
&gt; &gt;&gt; +++ b/drivers/net/mlx5/mlx5_ethdev.c<br>
&gt; &gt;&gt; @@ -368,6 +368,12 @@ mlx5_dev_infos_get(struct rte_eth_dev *d=
ev, struct rte_eth_dev_info *info)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0* Since we need one CQ per QP, the limit i=
s the minimum number<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0* between the two values.<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt;&gt; +=C2=A0 if (priv =3D=3D NULL || priv-&gt;sh =3D=3D NULL) {<br=
>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DRV_LOG(ERR,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;mlx5 shared data un=
available (primary process likely exited)&quot;);<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_errno =3D ENODEV;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -rte_errno;<br>
&gt; &gt;&gt; +=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; I don&#39;t think it&#39;s an issue on PMD level, but rather on<b=
r>
&gt; &gt; ethdev/multi-process handling level.<br>
&gt; <br>
&gt; I may be very wrong here, but can&#39;t the PMD use its internal &#39;=
shared&#39; state to<br>
&gt; somehow memorise the fact that a secondary process has attached, in or=
der to not<br>
&gt; let the primary process close in the first place (before the secondary=
 process<br>
&gt; detaches)? Or is this going to violate some established convention?<br=
>
<br>
It looks to be a good idea.<br>
<br>
&gt; &gt; When primary process closes the port, ethdev library zeroes and f=
rees<br>
&gt; &gt; device data shared between processes.<br>
&gt; &gt; ethdev port data (rte_eth_dev) on secondary is not updated so it =
now points to<br>
&gt; &gt; invalid data. rte_eth_dev_info_get() is not the only API call aff=
ected.<br>
&gt; &gt;<br>
&gt; &gt; If the primary process closes the port before exiting<br>
&gt; &gt; (like testpmd does) and it exits before the secondary,<br>
&gt; &gt; the any driver call seems invalid because of that use-after-free =
behavior.<br>
&gt; &gt;<br>
&gt; &gt; @Thomas, @Andrew - Do you happen to know if doing anything on eth=
dev ports<br>
&gt; &gt; in secondary process after primary has gracefully exited is suppo=
rted?<br>
<br>
No there is no statement about whether it is supported or not.<br>
I think we should at least return an error instead of crashing.<br>
<br>
<br>
</blockquote></div>

--000000000000301bc2063a899f62--
