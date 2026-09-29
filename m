Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07833CA5FAD
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 22:44:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B53D8402A2;
	Wed, 30 Sep 2026 00:44:16 +0200 (CEST)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by mails.dpdk.org (Postfix) with ESMTP id 4E9A0400EF
 for <dev@dpdk.org>; Wed, 30 Sep 2026 00:44:15 +0200 (CEST)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c29703cb796so663923366b.2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 15:44:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790721855; cv=none;
 d=google.com; s=arc-20260327;
 b=bCPqR5KpWiy3UuW1lEzUGJpDPRzLFDRh6IOrv+6pSVn4oJ3xLYESS/IuEgsXGFa8RC
 N5l2C4EuXVC+KtX1PeCBy2EqYgBT326Tmgl/tPcleRRiH4NBt83bWdeJGfgWELigJr/w
 sDOJf38ibkNKRw7QNlLPDvG6uLgwUkobP6zXTApdmJ/a6BsjfRQr28G0gPyRM+nDIIi4
 yEfPuKyXgxoo1lAwxEfu/w2o6PXX9d9VufmyR8jBy/YNDruteE0IkPfLtzskeKdbLMiS
 fEAxQWt18ubwJ9cN7K4WZ196l4MwvypHHzcDb4BfqyNKY2ZqlPxiY/N+1nnl2uAmDFc8
 gboQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iPkOrwl71jriZ2xJsIa68syY7OKAT39Zqh+v35VXW5M=;
 fh=rnFFTt//QmCsVZg9iNSmuQwHR72t9i371NRT/9SWlq4=;
 b=cVLlu9yjli+//6AMHalsXZ2YS7SbK6XMtlN6cMuNL2kTDdThBEvVT3TbyONVdoIMhV
 Hn/vHC5SViBHz0uW/MgnuNe877mfbyWqmaSlnBf/FRjdN0qOcPh3YtYOZfYRhwzrZqVQ
 /5DIP1rtBE4xqlS2e/DCZq9l/mLc8Id5J1MhDDvxffZOrM/QgYwtiGrJDxdLlHmPOyDs
 VSlyFwe14VDQiJODjVyY9T5dyRygMtmIFpUcqCUmS5YzGzotbnizhUH1bHHtqYncdyqn
 TDpycY0lNqZ0o73cUMux/K6BGHajX7uxUPP4AJ0Ci6EWPsMwKqblXBAbEJfgLgUIHNSh
 rNdA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790721855; x=1791326655; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iPkOrwl71jriZ2xJsIa68syY7OKAT39Zqh+v35VXW5M=;
 b=n5xNwzDP+c1KWgou70hYUkHGU1lN8r+MMfngthHcxIvUX6+Crg5Gl8IvivCXlOQJOu
 e7ZAcIzQv2+EnUiXo3edmnQQ5FnSMXdb4kTO4DdqtKA2dMNNzCb1rq4Y3VRTZBypHGlC
 QAublgLyF2q9sl20hTSb12plZFypfKPjU9s2gOzwyPuw5IplI+5wzAhWkkHQh8jCxPTL
 rRtTPKxxu1Xd7KjVPA6CiH16vWlgDAlpNS2UArA4OUpv4c2b2opGvtHWKWWqUEBlgRR0
 FRaLvheAdaVjXTu9gMcXfE7SHVl6M0KlfLK1Dt3vNn805wb50dIwmcT7Ny9o0EEtTN3D
 oqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790721855; x=1791326655;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iPkOrwl71jriZ2xJsIa68syY7OKAT39Zqh+v35VXW5M=;
 b=dvE2/xzpG9XQcXLTzyRq+AmQw7hBYHri+lhy6xSO5bc9Y389HW9ki6UUsEvGc5sMCi
 FEaNAIdDf1+hxaa5gWsG9NMKkB9OQixe1Dw2KcgzloPcRij9pqqdd5CPx0Lx6oJixWq1
 abwfb6vcsNzStqGlXmwmMqAsLls1uaNPCAtxrCOhb6teqNYJ0Ia8G21HK7VUEN9HlN3G
 DJiQ2xSpZo9zXAZU/xVFkN0pF7BvMN+NkdDm65FsSNT01xdGI2tfH/e1dGncmpp13oOG
 JzwvDdC7mXzVcatoRdBw7ZoIDTlmR68sZc+5+LwG1QMNa1U4iZoKSaDQo2dBmewrmQod
 bswA==
X-Gm-Message-State: AFuF++lnxq8adadEIFFsDAxTNVmxMLswY+nwaE14i94i43rDJxA1B61O
 9Ps4SSenhAT//VrK++01XbPR1vzNgyWgu6HsNF8eZj2RfO5IGDJi4D/ML++hKtXFbh/RTQi5hBp
 TG0w/XPIxjGZY5Preb8eeERLmsTTedtL/izGE4syMjV7zmePQFR/n4Rhv0Bc=
X-Gm-Gg: AYBFou3mgjjANvZSyp9uE0yedkOu26BqagHqX7mA86UCOFtrTW9zG0nZViZvLDE1mF3
 nSMV+cIy9j05Iy1uuIp5ncGOPjkQU9LmRM1ZC7xn/BfbqwHHMF+Mv6Eo+0RJ3uje/F6iymMQFUz
 CzDrEPo5HcX9pj0jXCCQtgn1s3ejWSoEnR+xHuluZzSOSU6wn67KFGVJiNhp/RFIB9cpzJu6qtT
 z72irjLmSP8Q00NRfSXMKsP1hj7YwxBYRTZ0OYOSPzXXjtSAQ/B0YdhQQuB30M9Qma0cfS1S49q
 /7Or9IpDhUBS+jwSBneOJSAKpgFc3feHnO99UCksVIiiRkhMeQ3DZfOtzEYGI5+dduc+R2hzsQU
 /8kJ9xFeC5dg=
X-Received: by 2002:a17:907:9704:b0:c2d:b9b4:f4d1 with SMTP id
 a640c23a62f3a-c2e15c0daa7mr69653266b.6.1790721854216; Tue, 29 Sep 2026
 15:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
 <20260923010742.2468145-3-joshwash@google.com>
 <arOACkkEd71gFm5u@bricha3-mobl1.ger.corp.intel.com>
 <arOBJjd_dnv1a5E-@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <arOBJjd_dnv1a5E-@bricha3-mobl1.ger.corp.intel.com>
From: Joshua Washington <joshwash@google.com>
Date: Tue, 29 Sep 2026 15:44:02 -0700
X-Gm-Features: AclHuK8K1_AEg7bx_UmZpFgt4Ra6nUZP7wMvXRR-BsM2ol-4s_5f5ZM0Egx4OJI
Message-ID: <CALuQH+VtGnhmPoq4KpLuphM_tmXs2zu42dVDP5=M0Hiqvx2FkA@mail.gmail.com>
Subject: Re: [PATCH v3 02/16] net/i40e: use common division round up macro
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>
Content-Type: multipart/alternative; boundary="000000000000042afd065ca6ecdd"
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

--000000000000042afd065ca6ecdd
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 23, 2026, 00:35 Bruce Richardson <bruce.richardson@intel.com>
wrote:

> On Wed, Sep 23, 2026 at 08:30:18AM +0100, Bruce Richardson wrote:
> > On Tue, Sep 22, 2026 at 06:07:25PM -0700, Joshua Washington wrote:
> > > The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.
> > >
> > > Signed-off-by: Joshua Washington <joshwash@google.com>
> > > Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > > ---
> > >  drivers/net/intel/i40e/base/i40e_osdep.h | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
>
> FYI: Just a note for i40e and the other intel drivers: the osdep.h files
> have moved in the repo in next-net-intel tree, so this patch will conflict
> once those changes are merged to main. Therefore, I'd suggest not merging
> this till after the pull, and then adjusting the paths in the patch on
> apply for simplicity of merge.
>
> Thanks,
> /Bruce
>
> > > diff --git a/drivers/net/intel/i40e/base/i40e_osdep.h
> b/drivers/net/intel/i40e/base/i40e_osdep.h
> > > index 9c5a94f055..93620f5c50 100644
> > > --- a/drivers/net/intel/i40e/base/i40e_osdep.h
> > > +++ b/drivers/net/intel/i40e/base/i40e_osdep.h
> > > @@ -227,12 +227,11 @@ struct i40e_spinlock {
> > >  #define i40e_memset(a, b, c, d) memset((a), (b), (c))
> > >  #define i40e_memcpy(a, b, c, d) memcpy((a), (b), (c))
> > >
> > > -#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
> > >  #define DELAY(x) rte_delay_us_sleep(x)
> > >  #define i40e_usec_delay(x) DELAY(x)
> > >  #define i40e_msec_delay(x) DELAY(1000 * (x))
> > >  #define udelay(x) DELAY(x)
> > >  #define msleep(x) DELAY(1000*(x))
> > > -#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
> > > +#define usleep_range(min, max) msleep(RTE_DIV_ROUND_UP(min, 1000))
> > >
> > >  #endif /* _I40E_OSDEP_H_ */
> > > --
> > > 2.55.0.1082.g2b9226bbc0-goog
> > >


Ah, I missed this. Thanks for the update. I will hold off on a v3 if it is
necessary until the main branch is updated.

--000000000000042afd065ca6ecdd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"auto"><div dir=3D"auto"><br></div><div data-sm=
artmail=3D"gmail_signature" dir=3D"auto"><div dir=3D"ltr"><span style=3D"co=
lor:rgb(0,0,0);font-family:Tinos;font-size:medium">=C2=A0</span><br></div><=
/div><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr" class=3D"=
gmail_attr">On Wed, Sep 23, 2026, 00:35 Bruce Richardson &lt;<a href=3D"mai=
lto:bruce.richardson@intel.com" target=3D"_blank">bruce.richardson@intel.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Wed, Sep 23, 20=
26 at 08:30:18AM +0100, Bruce Richardson wrote:<br>
&gt; On Tue, Sep 22, 2026 at 06:07:25PM -0700, Joshua Washington wrote:<br>
&gt; &gt; The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant=
.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Joshua Washington &lt;<a href=3D"mailto:joshwash@g=
oogle.com" rel=3D"noreferrer" target=3D"_blank">joshwash@google.com</a>&gt;=
<br>
&gt; &gt; Reviewed-by: Stephen Hemminger &lt;<a href=3D"mailto:stephen@netw=
orkplumber.org" rel=3D"noreferrer" target=3D"_blank">stephen@networkplumber=
.org</a>&gt;<br>
&gt; Acked-by: Bruce Richardson &lt;<a href=3D"mailto:bruce.richardson@inte=
l.com" rel=3D"noreferrer" target=3D"_blank">bruce.richardson@intel.com</a>&=
gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 drivers/net/intel/i40e/base/i40e_osdep.h | 3 +--<br>
&gt; &gt;=C2=A0 1 file changed, 1 insertion(+), 2 deletions(-)<br>
&gt; &gt; <br>
<br>
FYI: Just a note for i40e and the other intel drivers: the osdep.h files<br=
>
have moved in the repo in next-net-intel tree, so this patch will conflict<=
br>
once those changes are merged to main. Therefore, I&#39;d suggest not mergi=
ng<br>
this till after the pull, and then adjusting the paths in the patch on<br>
apply for simplicity of merge.<br>
<br>
Thanks,<br>
/Bruce<br>
<br>
&gt; &gt; diff --git a/drivers/net/intel/i40e/base/i40e_osdep.h b/drivers/n=
et/intel/i40e/base/i40e_osdep.h<br>
&gt; &gt; index 9c5a94f055..93620f5c50 100644<br>
&gt; &gt; --- a/drivers/net/intel/i40e/base/i40e_osdep.h<br>
&gt; &gt; +++ b/drivers/net/intel/i40e/base/i40e_osdep.h<br>
&gt; &gt; @@ -227,12 +227,11 @@ struct i40e_spinlock {<br>
&gt; &gt;=C2=A0 #define i40e_memset(a, b, c, d) memset((a), (b), (c))<br>
&gt; &gt;=C2=A0 #define i40e_memcpy(a, b, c, d) memcpy((a), (b), (c))<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt; -#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))<br>
&gt; &gt;=C2=A0 #define DELAY(x) rte_delay_us_sleep(x)<br>
&gt; &gt;=C2=A0 #define i40e_usec_delay(x) DELAY(x)<br>
&gt; &gt;=C2=A0 #define i40e_msec_delay(x) DELAY(1000 * (x))<br>
&gt; &gt;=C2=A0 #define udelay(x) DELAY(x)<br>
&gt; &gt;=C2=A0 #define msleep(x) DELAY(1000*(x))<br>
&gt; &gt; -#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))<b=
r>
&gt; &gt; +#define usleep_range(min, max) msleep(RTE_DIV_ROUND_UP(min, 1000=
))<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 #endif /* _I40E_OSDEP_H_ */<br>
&gt; &gt; -- <br>
&gt; &gt; 2.55.0.1082.g2b9226bbc0-goog<br>
&gt; &gt;</blockquote></div><div dir=3D"auto"><br></div><div dir=3D"auto">A=
h, I missed this. Thanks for the update. I will hold off on a v3 if it is n=
ecessary until the main branch is updated.</div></div>
</div>

--000000000000042afd065ca6ecdd--
