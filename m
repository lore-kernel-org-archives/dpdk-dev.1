Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E946ACFD313
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 15:47:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D59BE4067A;
	Mon, 24 Nov 2025 16:47:25 +0100 (CET)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id 70F75402B1
 for <dev@dpdk.org>; Mon, 24 Nov 2025 16:47:24 +0100 (CET)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-11beb0a7bd6so5205145c88.1
 for <dev@dpdk.org>; Mon, 24 Nov 2025 07:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763999243; x=1764604043; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GADW4yAaUf2h4VPJqWbusnneUIiXFrHr6jW2F3JbDvw=;
 b=M4uRMCmT1iea0bgSFLSoseMbJKkL4Obr/9/yB5OwgcT/GbktRC40x9Opa7vFE4c/ET
 40LUj7C62MLcUonJMSzOOqYenYp2maKRP1ABoZo2bws5ERgbgoiQCSYwD3VxtObMtKIV
 D+dIR91J7pGFhxcWGfrqUriM4oED1+kpkFukc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763999243; x=1764604043;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GADW4yAaUf2h4VPJqWbusnneUIiXFrHr6jW2F3JbDvw=;
 b=w9w064F6+7hGvOUmv6qnUK133OYEt84KcTkwTpeH9FC4zedwXaWNNw1z8iaHGoAbI+
 qfqANErcUUkgT18C2wXMFbtWxjxXYANm0Cof/38wNdWfJIqjkSZ3xO1PQGyS7+8yDCjm
 cwskFj4WKrn89yziPODmJ7xVqW0FOJReqecQ9Dj4x/9K32uqfIaQhf6cUxJ3TChGVk9L
 aqjXnOSa5Zeg+lo9bcU568+uas1y6Jj+AHgT6IKLMYya3rQmvu7nrf7+XaB8a+4psawR
 68IirW7hvruiGSW6lQwGHgPW4+2gj2os6pf+ISEmBTfZ5PmhAM/fx+LfhW0wv+Smphj1
 XIuA==
X-Gm-Message-State: AOJu0YyDwk73vFLNqk4iLupZCUDmxNz6VcFmqTyDavzXgDBB+UJzhlon
 0E0Itd8b7w34/bD+yp139FIZShBtYoSPyNaFA5Elk4OVuJvDz18x/HItiiSMo17o1ky42XeXmTh
 ZUYNpesEvvRufv/2KtukWJCyIqBDdguhtKxM5weUKrQ==
X-Gm-Gg: ASbGncta7eowqWdPDrgPLk64Cusy5aIB4worFTdDWodtvkKnGGk/aMRUgE/YqJl8lY6
 WqZ9bwBCkJ7TXVlAUnKzelYgj5sREdp0CMLwR2Rw3FJO99q+uqNaM7+6WlyXjHefq49YpWPeuBy
 REVW0bBtsxrsB6YgO1X3iA4N4/DdQUAy6otNcgpOZkjOM9lCROvlFDDJLe7j4/mJZBHPPhIVYqj
 /I3KofhlyNBjjV9DN7mit7MGaqiTN+V6SQK81gLjhOLS0IbPjH5R0MQLjLrefMPuhqfl88vDP3A
 ryWFrg4AE0lsVDwkGWcLVkZqd4bN
X-Google-Smtp-Source: AGHT+IH3tkG9lIWE6TkzzOSDTTzgc17NeUxfxaR4FzobuSoBHEgjdUxV3Xf5rxb8ZsJvvTbgkzMMO77E6jkGqKa4Hq4=
X-Received: by 2002:a05:7022:e25:b0:11a:515c:e891 with SMTP id
 a92af1059eb24-11c94a4db03mr9038922c88.0.1763999243373; Mon, 24 Nov 2025
 07:47:23 -0800 (PST)
MIME-Version: 1.0
References: <20251121-jk-dpdk-iavf-rx-timestamping-fix-v1-1-21c9a337a6f2@intel.com>
In-Reply-To: <20251121-jk-dpdk-iavf-rx-timestamping-fix-v1-1-21c9a337a6f2@intel.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 24 Nov 2025 10:45:58 -0500
X-Gm-Features: AWmQ_bnaHGMgMfTNBn1w0A4U_OFHJd6prfqSJS4QOmYRJRpWBfTNTO6Kvh8TuM4
Message-ID: <CAJvnSUBXPXGCGwAnqryY+OP=8_Dtji8f8SW-DEamjSGABZ4DWA@mail.gmail.com>
Subject: Re: [PATCH] net/iavf: check PTP capabilities during init
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000491e6206445914b7"
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

--000000000000491e6206445914b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi. There are some DTS failures on this testbed due to misconfiguration
applied by us at UNH last week. I'm fixing it and rerunning testing which
will update the CI checks for your patchseries.

On Fri, Nov 21, 2025 at 6:39=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com>
wrote:

> Commit d21c2fe6e5a1 ("net/iavf: fix check for PF Rx timestamp support")
> added a check against whether the PF has actually enabled Rx
> timestamping in iavf_dev_info_get(). Unfortunately, this function may be
> called prior to the PTP capabilities being exchanged, which results in
> Rx timestamping not being supported.
>
> Fix this by checking the PF PTP capabilities near the end of
> iavf_dev_init(). This ensures the VF knows the capabilities at the point
> where the iavf_dev_info_get() function can be called. Doing the check at
> init is better than inside the info callback, as the info callback is
> called many times.
>
> The capability exchange in iavf_dev_start() is kept to ensure that
> capabilities are updated after resets.
>
> Fixes: d21c2fe6e5a1 ("net/iavf: fix check for PF Rx timestamp support")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> My recent fix to prevent enabling Rx timestamping on PFs which do support
> PTP capability but do not report Rx timestamping accidentally broke PFs
> which *do* support Rx timestamping. This is because the driver did not
> exchange capability before reporting its device info. Fix this by checkin=
g
> PF capabilities during iavf_dev_init().
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index 3ef766de4704..9b07b11a6b51 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -2887,6 +2887,14 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
>                 }
>         }
>
> +       /* Get PTP caps early to verify device capabilities */
> +       if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP) {
> +               if (iavf_get_ptp_cap(adapter)) {
> +                       PMD_INIT_LOG(ERR, "Failed to get ptp capability")=
;
> +                       goto security_init_err;
> +               }
> +       }
> +
>         iavf_default_rss_disable(adapter);
>
>         iavf_dev_stats_reset(eth_dev);
>
> ---
> base-commit: ef98b88455bf4a7c8b7aa3106a761c9e9270d6a3
> change-id: 20251121-jk-dpdk-iavf-rx-timestamping-fix-abdcb42f0197
>
> Best regards,
> --
> Jacob Keller <jacob.e.keller@intel.com>
>
>

--000000000000491e6206445914b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi. There are some DTS failures on this testbed due t=
o misconfiguration applied by us at UNH last week. I&#39;m fixing it and re=
running testing=C2=A0which will update the=C2=A0CI checks for your patchser=
ies.</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 21, 2025 at 6:39=E2=80=AFPM Jac=
ob Keller &lt;<a href=3D"mailto:jacob.e.keller@intel.com">jacob.e.keller@in=
tel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Commit d21c2fe6e5a1 (&quot;net/iavf: fix check for PF Rx timestamp s=
upport&quot;)<br>
added a check against whether the PF has actually enabled Rx<br>
timestamping in iavf_dev_info_get(). Unfortunately, this function may be<br=
>
called prior to the PTP capabilities being exchanged, which results in<br>
Rx timestamping not being supported.<br>
<br>
Fix this by checking the PF PTP capabilities near the end of<br>
iavf_dev_init(). This ensures the VF knows the capabilities at the point<br=
>
where the iavf_dev_info_get() function can be called. Doing the check at<br=
>
init is better than inside the info callback, as the info callback is<br>
called many times.<br>
<br>
The capability exchange in iavf_dev_start() is kept to ensure that<br>
capabilities are updated after resets.<br>
<br>
Fixes: d21c2fe6e5a1 (&quot;net/iavf: fix check for PF Rx timestamp support&=
quot;)<br>
Signed-off-by: Jacob Keller &lt;<a href=3D"mailto:jacob.e.keller@intel.com"=
 target=3D"_blank">jacob.e.keller@intel.com</a>&gt;<br>
---<br>
My recent fix to prevent enabling Rx timestamping on PFs which do support<b=
r>
PTP capability but do not report Rx timestamping accidentally broke PFs<br>
which *do* support Rx timestamping. This is because the driver did not<br>
exchange capability before reporting its device info. Fix this by checking<=
br>
PF capabilities during iavf_dev_init().<br>
---<br>
=C2=A0drivers/net/intel/iavf/iavf_ethdev.c | 8 ++++++++<br>
=C2=A01 file changed, 8 insertions(+)<br>
<br>
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/=
iavf_ethdev.c<br>
index 3ef766de4704..9b07b11a6b51 100644<br>
--- a/drivers/net/intel/iavf/iavf_ethdev.c<br>
+++ b/drivers/net/intel/iavf/iavf_ethdev.c<br>
@@ -2887,6 +2887,14 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get PTP caps early to verify device capabili=
ties */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (vf-&gt;vf_res-&gt;vf_cap_flags &amp; VIRTCH=
NL_VF_CAP_PTP) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (iavf_get_ptp_ca=
p(adapter)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0PMD_INIT_LOG(ERR, &quot;Failed to get ptp capability&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto security_init_err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 iavf_default_rss_disable(adapter);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 iavf_dev_stats_reset(eth_dev);<br>
<br>
---<br>
base-commit: ef98b88455bf4a7c8b7aa3106a761c9e9270d6a3<br>
change-id: 20251121-jk-dpdk-iavf-rx-timestamping-fix-abdcb42f0197<br>
<br>
Best regards,<br>
--=C2=A0 <br>
Jacob Keller &lt;<a href=3D"mailto:jacob.e.keller@intel.com" target=3D"_bla=
nk">jacob.e.keller@intel.com</a>&gt;<br>
<br>
</blockquote></div>

--000000000000491e6206445914b7--
