Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9624AC7115B
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 18:50:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC085402EB;
	Mon, 23 Jun 2025 20:50:23 +0200 (CEST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by mails.dpdk.org (Postfix) with ESMTP id C4F284014F;
 Mon, 23 Jun 2025 20:50:21 +0200 (CEST)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-6077dea37easo8623494a12.3; 
 Mon, 23 Jun 2025 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750704621; x=1751309421; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v2AwSofeK1ZRWVGkI4Mb1GhzxIHd9YJX8X1vyzTaWnI=;
 b=IdjPRfQovwAUQEbZz9n+xhTCNiEXNrHEd6Bj0mrH2495rX//p9/3Pz4iro6YkSH+jx
 zr3qk4qzI3IXnSN3F8ekbke7S2LZSuF240BTdUUjtXhH9N6JT/1gUWWU0sW6czr7Rd9z
 1jDyS6kV+ncOi5zSbx79T8WqqQ7qXJlS0AvI+GGQJtfuK1LoqTSq3E4r2MbgeNUeXXgG
 CIpz1tSVs+HjlPPnYys7QzZfR3iRYDcKfAoy/N5fWpo8fYtIfhEOUszx8AlLELPYJLCL
 4+LbSuAR+1NriVaxNXFd/h2vz/jdC1Z/WJV2EUmfdLUmxXNcH/NhPtFgFw+jy3XuSXec
 UkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750704621; x=1751309421;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v2AwSofeK1ZRWVGkI4Mb1GhzxIHd9YJX8X1vyzTaWnI=;
 b=i5qoEM92mmaen32bG5W4R4o4kI/9gx0FIk4ip+qSkRn5dUjm4nye+es1q4o98hCbH2
 UNorA/lFDxHH9jq7TfIYsh8fyD1zai4rghG4aOqa+BW5yNC8h0hLdYax7+eKoncM6D3T
 L4L3z9LN6IvFOzq+oAQf84/v7Sm7VgfoGog6sPoowX5X4pCj1m2E4Dv5Y+Ke0VQJwbWf
 eSg4V9E3I6AnAPWQtsTNXVI9MOqSfNOEeXR3/JuNDNKttS62QNyv6544FJ+uiW1ik6fq
 3KDhmCULCQgky14C7xA5m1mv9qqMAoVxTh1hJr+nIm0KXYY6ZFtUBGwiQqhhFTt6dJVr
 DC8g==
X-Gm-Message-State: AOJu0YzvFO2VGiokszTjVbJ5fhg2iDUInnEqsufNRa+S/tienhW7gmCB
 hOPYum4vxpgHqZrvraxGJ8khKly2Hu+joZ95WsB8rVDUuOqB9GQHhm4FZXvzH5pg+5ufTD6HzRv
 EErVHXTf+I8qOr+e0lV13rpcQx62GnN0Y516h
X-Gm-Gg: ASbGncvnuBXh0ssFC5h/Z28CvCCYvn0FlAIsk9IoxB5ft+jYbyFbcuTIgOnbDdpmj5K
 krK99MD8cQ+BkYEFSeyQlw/wNjFs5Uwfzd+Byp2+EPzMS6ONOktZaEj81rZpo+B41mAQaATiYEb
 97gblixyxFzgAGPKRzZeXhD++5WgEFjiemmHMXZVx1TQ==
X-Google-Smtp-Source: AGHT+IGNougIPMnLCZUy8+tlgl9yhonzX+e0jyCINrvbN603PTUSHm6KzOfmrM0JdRO35nxJjj9qqv2YTyznIFGEwL8=
X-Received: by 2002:a17:907:72c9:b0:add:fc26:c1c4 with SMTP id
 a640c23a62f3a-ae057ce6985mr1378751166b.59.1750704620532; Mon, 23 Jun 2025
 11:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250621015624.35284-1-amiyaranjan.mohakud@gmail.com>
 <20250623181136.48239-1-amiyaranjan.mohakud@gmail.com>
In-Reply-To: <20250623181136.48239-1-amiyaranjan.mohakud@gmail.com>
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Date: Tue, 24 Jun 2025 00:20:09 +0530
X-Gm-Features: Ac12FXxwsnzTrBuGLDyBhXCDhtvdey7QNK-UchOImrIIqM3G5E4mNUrCA-lMo10
Message-ID: <CAL+mCpOU+q542mGrA+aT+nO8Rs4dtAY==U2SbvYJFvVd1e4qCA@mail.gmail.com>
Subject: Re: [PATCH v2] net/iavf: fix VLAN offload strip flag
To: dev@dpdk.org, ciara.loftus@intel.com
Cc: stable@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000003792b063841afb5"
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

--00000000000003792b063841afb5
Content-Type: text/plain; charset="UTF-8"

Hi Ciara
Thanks for your effort in reproducing the issue and confirming that the
patch works. However, I have taken care of the indentation in the commit
message and sent out a v2 patch. Appreciate your review comments.

*>>>Perhaps we should make the disabling unconditional or even better make
it depend on if the stripping was enabled although I'm not sure if there's
a way to check for this.*

I understand and agree with your point of disabling vlan_strip after
checking if the stripping is enabled. But like you mentioned, I'm also not
sure if there is any way to know that.

However, I think, the current check also does a good job by checking the
dev_conf parameter against RTE_ETH_RX_OFFLOAD_VLAN_STRIP and re-disables
the vlan_strip after every vlan_add operation.


Thanks
Amiya


On Mon, 23 Jun 2025 at 23:41, Amiya Ranjan Mohakud <
amiyaranjan.mohakud@gmail.com> wrote:

> For i40e kernel drivers which support either vlan(v1) or vlan(v2)
> VIRTCHNL OP,it will set strip on when setting filter on. But dpdk
> side will not change strip flag. To be consistent with dpdk side,
> explicitly disable strip again.
>
> Bugzilla ID:1725
> Cc: stable@dpdk.org
>
> v2:
> - Fixed indentation in commit message
>
> Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 48 +++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index b3dacbef84..f93e7bf9ae 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -1378,13 +1378,38 @@ iavf_dev_del_mac_addr(struct rte_eth_dev *dev,
> uint32_t index)
>         vf->mac_num--;
>  }
>
> +static int
> +iavf_disable_vlan_strip_ex(struct rte_eth_dev *dev, int on)
> +{
> +       /* For i40e kernel drivers which supports both vlan(v1 & v2)
> VIRTCHNL OP,
> +        * it will set strip on when setting filter on but dpdk side will
> not
> +        * change strip flag. To be consistent with dpdk side, explicitly
> disable
> +        * strip again.
> +        *
> +        */
> +       struct iavf_adapter *adapter =
> +               IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> +       struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
> +       int err;
> +
> +       if (adapter->hw.mac.type == IAVF_MAC_XL710 ||
> +           adapter->hw.mac.type == IAVF_MAC_VF ||
> +           adapter->hw.mac.type == IAVF_MAC_X722_VF) {
> +               if (on && !(dev_conf->rxmode.offloads &
> RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {
> +                       err = iavf_disable_vlan_strip(adapter);
> +                       if (err)
> +                               return -EIO;
> +               }
> +       }
> +       return 0;
> +}
> +
>  static int
>  iavf_dev_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int
> on)
>  {
>         struct iavf_adapter *adapter =
>                 IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
>         struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
> -       struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
>         int err;
>
>         if (adapter->closed)
> @@ -1394,7 +1419,8 @@ iavf_dev_vlan_filter_set(struct rte_eth_dev *dev,
> uint16_t vlan_id, int on)
>                 err = iavf_add_del_vlan_v2(adapter, vlan_id, on);
>                 if (err)
>                         return -EIO;
> -               return 0;
> +
> +               return iavf_disable_vlan_strip_ex(dev, on);
>         }
>
>         if (!(vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN))
> @@ -1404,23 +1430,7 @@ iavf_dev_vlan_filter_set(struct rte_eth_dev *dev,
> uint16_t vlan_id, int on)
>         if (err)
>                 return -EIO;
>
> -       /* For i40e kernel driver which only supports vlan(v1) VIRTCHNL OP,
> -        * it will set strip on when setting filter on but dpdk side will
> not
> -        * change strip flag. To be consistent with dpdk side, disable
> strip
> -        * again.
> -        *
> -        * For i40e kernel driver which supports vlan v2, dpdk will invoke
> vlan v2
> -        * related function, so it won't go through here.
> -        */
> -       if (adapter->hw.mac.type == IAVF_MAC_XL710 ||
> -           adapter->hw.mac.type == IAVF_MAC_X722_VF) {
> -               if (on && !(dev_conf->rxmode.offloads &
> RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {
> -                       err = iavf_disable_vlan_strip(adapter);
> -                       if (err)
> -                               return -EIO;
> -               }
> -       }
> -       return 0;
> +       return iavf_disable_vlan_strip_ex(dev, on);
>  }
>
>  static void
> --
> 2.39.5 (Apple Git-154)
>
>

--00000000000003792b063841afb5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div style=3D"font-family:verdana,sans-serif;color:rg=
b(103,78,167)" class=3D"gmail_default">Hi=C2=A0Ciara</div><div style=3D"fon=
t-family:verdana,sans-serif;color:rgb(103,78,167)" class=3D"gmail_default">=
Thanks for your effort in reproducing the issue and confirming that the pat=
ch works.=C2=A0However, I have taken care of the indentation in the commit =
message and sent out a v2 patch.=C2=A0Appreciate your review=C2=A0comments.=
</div><div style=3D"font-family:verdana,sans-serif;color:rgb(103,78,167)" c=
lass=3D"gmail_default"><br></div><div style=3D"font-family:verdana,sans-ser=
if;color:rgb(103,78,167)" class=3D"gmail_default"><i>&gt;&gt;&gt;Perhaps we=
 should make the disabling unconditional or even better make=20
it depend on if the stripping was enabled although I&#39;m not sure if=20
there&#39;s a way to check for this.</i></div><div style=3D"font-family:ver=
dana,sans-serif;color:rgb(103,78,167)" class=3D"gmail_default"><br></div><d=
iv style=3D"font-family:verdana,sans-serif;color:rgb(103,78,167)" class=3D"=
gmail_default">I understand and agree with your point of disabling vlan_str=
ip after checking if the stripping is enabled. But like you mentioned, I&#3=
9;m also not sure if there is any way to know that.</div><div style=3D"font=
-family:verdana,sans-serif;color:rgb(103,78,167)" class=3D"gmail_default"><=
br></div><div style=3D"font-family:verdana,sans-serif;color:rgb(103,78,167)=
" class=3D"gmail_default">However, I think, the current check also does a g=
ood job by checking the dev_conf parameter against=C2=A0RTE_ETH_RX_OFFLOAD_=
VLAN_STRIP and re-disables the vlan_strip after every vlan_add operation.</=
div><div style=3D"font-family:verdana,sans-serif;color:rgb(103,78,167)" cla=
ss=3D"gmail_default"><br></div><div style=3D"font-family:verdana,sans-serif=
;color:rgb(103,78,167)" class=3D"gmail_default"><br></div></div><div><div d=
ir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><di=
v dir=3D"ltr"><div><span style=3D"font-family:verdana,sans-serif">Thanks</s=
pan></div><div><span style=3D"font-family:verdana,sans-serif">Amiya</span><=
br></div></div></div></div><br></div><br><div class=3D"gmail_quote gmail_qu=
ote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 23 Jun 2025 at=
 23:41, Amiya Ranjan Mohakud &lt;<a href=3D"mailto:amiyaranjan.mohakud@gmai=
l.com">amiyaranjan.mohakud@gmail.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">For i40e kernel drivers which support e=
ither vlan(v1) or vlan(v2)<br>
VIRTCHNL OP,it will set strip on when setting filter on. But dpdk<br>
side will not change strip flag. To be consistent with dpdk side,<br>
explicitly disable strip again.<br>
<br>
Bugzilla ID:1725<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
v2:<br>
- Fixed indentation in commit message<br>
<br>
Signed-off-by: Amiya Ranjan Mohakud &lt;<a href=3D"mailto:amiyaranjan.mohak=
ud@gmail.com" target=3D"_blank">amiyaranjan.mohakud@gmail.com</a>&gt;<br>
---<br>
=C2=A0drivers/net/intel/iavf/iavf_ethdev.c | 48 +++++++++++++++++----------=
-<br>
=C2=A01 file changed, 29 insertions(+), 19 deletions(-)<br>
<br>
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/=
iavf_ethdev.c<br>
index b3dacbef84..f93e7bf9ae 100644<br>
--- a/drivers/net/intel/iavf/iavf_ethdev.c<br>
+++ b/drivers/net/intel/iavf/iavf_ethdev.c<br>
@@ -1378,13 +1378,38 @@ iavf_dev_del_mac_addr(struct rte_eth_dev *dev, uint=
32_t index)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vf-&gt;mac_num--;<br>
=C2=A0}<br>
<br>
+static int<br>
+iavf_disable_vlan_strip_ex(struct rte_eth_dev *dev, int on)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* For i40e kernel drivers which supports both =
vlan(v1 &amp; v2) VIRTCHNL OP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * it will set strip on when setting filter on =
but dpdk side will not<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * change strip flag. To be consistent with dpd=
k side, explicitly disable<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * strip again.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iavf_adapter *adapter =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IAVF_DEV_PRIVATE_TO=
_ADAPTER(dev-&gt;data-&gt;dev_private);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_conf *dev_conf =3D &amp;dev-&gt;=
data-&gt;dev_conf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adapter-&gt;hw.mac.type =3D=3D IAVF_MAC_XL7=
10 ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adapter-&gt;hw.mac.type =3D=3D IA=
VF_MAC_VF ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adapter-&gt;hw.mac.type =3D=3D IA=
VF_MAC_X722_VF) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (on &amp;&amp; !=
(dev_conf-&gt;rxmode.offloads &amp; RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0err =3D iavf_disable_vlan_strip(adapter);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (err)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
=C2=A0static int<br>
=C2=A0iavf_dev_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, i=
nt on)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iavf_adapter *adapter =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IAVF_DEV_PRIVATE_TO=
_ADAPTER(dev-&gt;data-&gt;dev_private);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iavf_info *vf =3D IAVF_DEV_PRIVATE_TO_VF=
(adapter);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_conf *dev_conf =3D &amp;dev-&gt;=
data-&gt;dev_conf;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int err;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adapter-&gt;closed)<br>
@@ -1394,7 +1419,8 @@ iavf_dev_vlan_filter_set(struct rte_eth_dev *dev, uin=
t16_t vlan_id, int on)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D iavf_add_de=
l_vlan_v2(adapter, vlan_id, on);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -EIO;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return iavf_disable=
_vlan_strip_ex(dev, on);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(vf-&gt;vf_res-&gt;vf_cap_flags &amp; VIRT=
CHNL_VF_OFFLOAD_VLAN))<br>
@@ -1404,23 +1430,7 @@ iavf_dev_vlan_filter_set(struct rte_eth_dev *dev, ui=
nt16_t vlan_id, int on)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* For i40e kernel driver which only supports v=
lan(v1) VIRTCHNL OP,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * it will set strip on when setting filter on =
but dpdk side will not<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * change strip flag. To be consistent with dpd=
k side, disable strip<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * again.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * For i40e kernel driver which supports vlan v=
2, dpdk will invoke vlan v2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * related function, so it won&#39;t go through=
 here.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adapter-&gt;hw.mac.type =3D=3D IAVF_MAC_XL7=
10 ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adapter-&gt;hw.mac.type =3D=3D IA=
VF_MAC_X722_VF) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (on &amp;&amp; !=
(dev_conf-&gt;rxmode.offloads &amp; RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0err =3D iavf_disable_vlan_strip(adapter);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (err)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return iavf_disable_vlan_strip_ex(dev, on);<br>
=C2=A0}<br>
<br>
=C2=A0static void<br>
-- <br>
2.39.5 (Apple Git-154)<br>
<br>
</blockquote></div>

--00000000000003792b063841afb5--
