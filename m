Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B59C44520
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 01:42:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF08340289;
	Tue, 21 Jul 2026 03:42:54 +0200 (CEST)
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com
 [209.85.210.225])
 by mails.dpdk.org (Postfix) with ESMTP id 7F7A640288
 for <dev@dpdk.org>; Tue, 21 Jul 2026 03:42:52 +0200 (CEST)
Received: by mail-pf1-f225.google.com with SMTP id
 d2e1a72fcca58-8487088510aso10878195b3a.0
 for <dev@dpdk.org>; Mon, 20 Jul 2026 18:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784598171; x=1785202971;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6WJPLrmCETIseRU4r2D0tITW+/jln5HId03OGPNSK8g=;
 b=gL1LYT6UJScSi3ZrXioRV9pYvVAqfpl3+0Xco3sfqGlrLiTgtNnIlCzmk8iOn1SKnL
 KIKtz7YVxQIwhPtxZVfH+3i3+xCdcl2/w0qv/wRGZzRfMFavnq7WMBe7E9hvdwhiW0pz
 BYk5hB0lmByNLXEnMImNHvFLiM9v5ZBMrUYbV+4lU1h0mqKmbA6SIsX3Kc8hsUiLpkxq
 2l3ObberIs31tf3HeSLEg4Uia/ODn77RAqomHG3roqZVrspo0ikPQ5RHXV0ozcsnwu+2
 MRWX2c1Fao/b79cwnn11FUUf7NqIg9AWLudpe+oHYNAXQ2nhFSAklPDJGxz1vAdS5+6d
 UvwA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqmxRa+fjXXrEmLpyzw3bG+8RKI36j5uZbO8ioXMSBGvlbVXL+ds0cSxVVzj8CWtCUsmDA=@dpdk.org
X-Gm-Message-State: AOJu0YwXZDMgX121K26yIfnujnxNCrjy27QRPkgkyOLMd7zAhIiy8z3m
 r/jSx4z6aB2pgtFfyRQs/gLavnt6dSys9LDgWO0IIcAQDZ6eh1RaYAxTor4EfiJPv7a3qM/cUOg
 SZMXDOufxfU5jt+P+zcQc/SfJUASNifEOEAMOdbHMuwTOtBcPBguolf+/ERCiDfM8THC4B3XFAD
 yvW3ZwUDvQptZKc7CFPq/Vm9Z3T6AqUztOIk8JLZokAKA/EJXUyBwZx7fzCxyMcwIYnu5y9bc4w
 DUxGw==
X-Gm-Gg: AfdE7clHeC90PdORhyS6fW3/S6YxENEksYiJIxiRMeQDHN5v34a8knzcvnLCz8A4be4
 W9ZoiKu3hmsmdD2mWTOpZ4eASZGw3fEg2VLozTlvhj4zdA52qB05GEBXrCr9O8KVkAb+UbETfag
 C2O4SqC3aKpxQiY20EvXvoPo46/oCqI9ZJKKbcBRm9KhuL7aOEWaPkSpoXE1f+XXg9TOAuDJLKt
 Nsi7/8GgcbputkJkV/6CoW+bE5xZ20IxmzbkB1vrMcBfERS97KPzIDA0pndnfhhwjdK2pLI5MBF
 Cz4+udYm06Vs0+IDDSLDaKQY8xmeQSt3SqBUgsdEOuJksKPJ1b+2oVx7H9U6P0iZplOK2UWezyi
 tmQ2fhb8nWFjK8cGN48txORlibOhcR9oZG4PjGBkCRjMQpqYFdrZ/+kzyJ3IOARZmBK/+jFjrIN
 DEOVrKqyQTiXFKexLO26qvcRQoWHXYOaZOrOpQ4b9oZ1k=
X-Received: by 2002:a05:6a20:7487:b0:3bf:6c05:ab with SMTP id
 adf61e73a8af0-3c3ad9d632bmr17736176637.58.1784598171180; 
 Mon, 20 Jul 2026 18:42:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
 by smtp-relay.gmail.com with ESMTPS id
 5a478bee46e88-3142a1bb757sm635117eec.17.2026.07.20.18.42.50
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 20 Jul 2026 18:42:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84e01a62d99so481034b3a.0
 for <dev@dpdk.org>; Mon, 20 Jul 2026 18:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1784598169; x=1785202969; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6WJPLrmCETIseRU4r2D0tITW+/jln5HId03OGPNSK8g=;
 b=YwUsQqIrS+AIvnHfe/VTvsUEBhFIy7PJdoFRD8kcXZZfMQfzUO8e4aOsiVm/E8rh79
 aGXNlFQn50M7cXg3CWyOke9Mfc4I8/Aqtw2oFXdG2M5wFeakq4o+jWWr90cFJ6Et5RVW
 ukLyGEQTDk+Ff2hanrt0/PE+lA2CZb4fJ1Kqc=
X-Forwarded-Encrypted: i=1;
 AHgh+RpX4X/rukP8jwPkQ0ZWFpBbX0imGQgj0qpXrKiJ5dZHZgTI9sprPmb3MwG0Od0qTLsKTGE=@dpdk.org
X-Received: by 2002:a05:6a00:21cb:b0:848:599f:26b with SMTP id
 d2e1a72fcca58-84c292d0fd8mr17403257b3a.14.1784598168949; 
 Mon, 20 Jul 2026 18:42:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:21cb:b0:848:599f:26b with SMTP id
 d2e1a72fcca58-84c292d0fd8mr17403224b3a.14.1784598168289; Mon, 20 Jul 2026
 18:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <b54ad1f1692a0274da705d446972efd1@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6596D@smartserver.smartshare.dk>
 <e0b59e0b-1fb7-4a7b-84bb-9fc47f4feb5a@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6596E@smartserver.smartshare.dk>
 <CA+BST0kV0w7teE2h8OVZ5Ont-BCrf6rSxw9+t+Bbn8hx6xUwtA@mail.gmail.com>
 <aliq6kqGI2TfyFoH@bricha3-mobl1.ger.corp.intel.com>
 <00fe4a299adc03ff7d39ef943e62b921@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65979@smartserver.smartshare.dk>
 <al3YgIWkXNihHGMv@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6597F@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6597F@smartserver.smartshare.dk>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Mon, 20 Jul 2026 21:42:31 -0400
X-Gm-Features: AUfX_mxpZb-O7IFe9jgS88G5FzHLM9DRKdtheQS-SU3hsq0TYGFX3kaQ9vI96BM
Message-ID: <CA+BST0mvrhPX9aw4CheJO5z5O7QWWe--uBuGhsvLxk7Xc+xAMQ@mail.gmail.com>
Subject: Re: mempool cache change
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 fengchengwen <fengchengwen@huawei.com>, dev@dpdk.org, 
 Wisam Jaddo <wisamm@nvidia.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Thomas Monjalon <thomas@monjalon.net>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000f3e0a30657152328"
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

--000000000000f3e0a30657152328
Content-Type: multipart/alternative; boundary="000000000000e3607b06571523a6"

--000000000000e3607b06571523a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 6:54=E2=80=AFAM Morten Br=C3=B8rup <mb@smartsharesy=
stems.com>
wrote:

> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Monday, 20 July 2026 10.13
> >
> > On Sat, Jul 18, 2026 at 04:07:05PM +0200, Morten Br=C3=B8rup wrote:
> > > > From: Kishore Padmanabha [mailto:kishore.padmanabha@broadcom.com]
> > > > Sent: Friday, 17 July 2026 19.10
> > > >
> > > > Hi Bruce,
> > > >
> > > > The below patch works fine for us. We tested all the different
> > packet
> > > > sizes.
> > > > Thanks for the patch. Do you want to push this patch since it is
> > not
> > > > changing the ABI/API?
> > >
> > > Too late in the release process.
> > >
> > > Let's postpone the discussion for DPDK 26.11, where API/ABI breakage
> > is allowed.
> >
> > Agreed. Let's not unnecessarily rush this.
> >
> > >
> > > I'm not strongly opposed to Bruce's algorithm, targeting a fill level
> > of 25 % from the edges and flushing/refilling up to 75 % of the cache
> > when necessary. It does have its advantages for some mempool access
> > patterns (which are not exotic).
> > > I just prefer the current algorithm, targeting a fill level of 50 %
> > and only flushing/refilling up to 50 % of the cache when necessary. It
> > performs better at random get/put access patterns, and the backend
> > transactions are smaller.
> > >
> > > For DPDK 26.11, where we can break the API/ABI, we can simply double
> > RTE_MEMPOOL_CACHE_MAX_SIZE to 1024, to compensate for reducing the
> > effective cache size from 150 % to 100 %.
> > > The mempool cache objs array will no longer be
> > [RTE_MEMPOOL_CACHE_MAX_SIZE * 2], but only
> > [RTE_MEMPOOL_CACHE_MAX_SIZE], so doubling RTE_MEMPOOL_CACHE_MAX_SIZE
> > will not increase the memory footprint, but allow using a cache size up
> > to 1024.
> >
> > My concern with this approach is that it won't automatically fix the
> > problem if we have users who experience a performance regression due to
> > the
> > mempool changes. While testpmd allows the mbcache size to be provided
> > via
> > parameter, end applications are likely to have it hardcoded. That means
> > that if an app does experience a regression, the author/user has to be
> > either aware of the mempool changes, or has to debug it down to the
> > mempool
> > and then know to increase the mempool cache size in the app.
> >
> > It's not an insurmountable problem, but one that needs to be very
> > clearly
> > called out in our documentation, what the change is, how it may affect
> > things and how to fix it.
>
> The release notes [1] do mention that the mempool algorithm has changed,
> and how some applications should adapt to it.
> They also do mention that the effective mempool cache size has changed,
> but not that applications can restore the previously 50 % larger effectiv=
e
> cache size by simply requesting a 50 % larger cache.
>
> Maybe we should move the notes about the mempool changes from the New
> Features section to the API Changes section, and mention how to increase
> the cache size to regain the reduction in effective size?
>
> [1]:
> https://github.com/DPDK/dpdk/blob/v26.07-rc4/doc/guides/rel_notes/release=
_26_07.rst?plain=3D1#L80
>
> >
> > On the other hand, in realworld, i.e. not just testpmd/l3fwd cases
> > doing
> > little packet processesing, I would be fairly hopeful that regressions
> > are
> > going to be few and very small.
>
> Yes.
> And some real world applications (most run-to-completion applications?)
> will get fewer mempool cache misses with the new algorithm.
> Best case a performance improvement exceeding the performance cost of the
> reduced effective cache size.
>
> >
> > >
> > > Please also note that the current implementation is carefully
> > designed to keep the transfers to/from the mempool backend CPU cache
> > aligned (assuming cache->size is 2^N and large enough).
> > > Refer to the parameters passed to
> > rte_mempool_ops_enqueue/dequeue_bulk().
> > > E.g. with mempool cache size 256, backend transfers are 128 objects,
> > 16 full cache lines.
> > > Using CPU cache aligned transfers has a few advantages:
> > > - There are no cache line ownership issues across different CPU cores
> > repeatedly accessing the backend.
> > > - The mempool backend drivers can be performance optimized for
> > transferring full CPU cache lines. (Both source and destination
> > addresses, and number of objects copied, are CPU cache aligned.
> > Assuming all transfers go via the mempool cache.)
> > >
> > > These details should be fine tuned in the implementation, if we do
> > proceed with Bruce's algorithm.
> > >
> > Yep, good points.
> >
> > /Bruce
>
> Sounds good. Documenting the limitation helps.


> PS:
> I have some API/ABI breaking mempool optimizations in the pipeline for
> DPDK 26.11.
> But let's try to concentrate on DPDK 26.07 for now. ;-)
>
>

--000000000000e3607b06571523a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 20,=
 2026 at 6:54=E2=80=AFAM Morten Br=C3=B8rup &lt;<a href=3D"mailto:mb@smarts=
haresystems.com">mb@smartsharesystems.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">&gt; From: Bruce Richardson [mailt=
o:<a href=3D"mailto:bruce.richardson@intel.com" target=3D"_blank">bruce.ric=
hardson@intel.com</a>]<br>
&gt; Sent: Monday, 20 July 2026 10.13<br>
&gt; <br>
&gt; On Sat, Jul 18, 2026 at 04:07:05PM +0200, Morten Br=C3=B8rup wrote:<br=
>
&gt; &gt; &gt; From: Kishore Padmanabha [mailto:<a href=3D"mailto:kishore.p=
admanabha@broadcom.com" target=3D"_blank">kishore.padmanabha@broadcom.com</=
a>]<br>
&gt; &gt; &gt; Sent: Friday, 17 July 2026 19.10<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Hi Bruce,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The below patch works fine for us. We tested all the differe=
nt<br>
&gt; packet<br>
&gt; &gt; &gt; sizes.<br>
&gt; &gt; &gt; Thanks for the patch. Do you want to push this patch since i=
t is<br>
&gt; not<br>
&gt; &gt; &gt; changing the ABI/API?<br>
&gt; &gt;<br>
&gt; &gt; Too late in the release process.<br>
&gt; &gt;<br>
&gt; &gt; Let&#39;s postpone the discussion for DPDK 26.11, where API/ABI b=
reakage<br>
&gt; is allowed.<br>
&gt; <br>
&gt; Agreed. Let&#39;s not unnecessarily rush this.<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; I&#39;m not strongly opposed to Bruce&#39;s algorithm, targeting =
a fill level<br>
&gt; of 25 % from the edges and flushing/refilling up to 75 % of the cache<=
br>
&gt; when necessary. It does have its advantages for some mempool access<br=
>
&gt; patterns (which are not exotic).<br>
&gt; &gt; I just prefer the current algorithm, targeting a fill level of 50=
 %<br>
&gt; and only flushing/refilling up to 50 % of the cache when necessary. It=
<br>
&gt; performs better at random get/put access patterns, and the backend<br>
&gt; transactions are smaller.<br>
&gt; &gt;<br>
&gt; &gt; For DPDK 26.11, where we can break the API/ABI, we can simply dou=
ble<br>
&gt; RTE_MEMPOOL_CACHE_MAX_SIZE to 1024, to compensate for reducing the<br>
&gt; effective cache size from 150 % to 100 %.<br>
&gt; &gt; The mempool cache objs array will no longer be<br>
&gt; [RTE_MEMPOOL_CACHE_MAX_SIZE * 2], but only<br>
&gt; [RTE_MEMPOOL_CACHE_MAX_SIZE], so doubling RTE_MEMPOOL_CACHE_MAX_SIZE<b=
r>
&gt; will not increase the memory footprint, but allow using a cache size u=
p<br>
&gt; to 1024.<br>
&gt; <br>
&gt; My concern with this approach is that it won&#39;t automatically fix t=
he<br>
&gt; problem if we have users who experience a performance regression due t=
o<br>
&gt; the<br>
&gt; mempool changes. While testpmd allows the mbcache size to be provided<=
br>
&gt; via<br>
&gt; parameter, end applications are likely to have it hardcoded. That mean=
s<br>
&gt; that if an app does experience a regression, the author/user has to be=
<br>
&gt; either aware of the mempool changes, or has to debug it down to the<br=
>
&gt; mempool<br>
&gt; and then know to increase the mempool cache size in the app.<br>
&gt; <br>
&gt; It&#39;s not an insurmountable problem, but one that needs to be very<=
br>
&gt; clearly<br>
&gt; called out in our documentation, what the change is, how it may affect=
<br>
&gt; things and how to fix it.<br>
<br>
The release notes [1] do mention that the mempool algorithm has changed, an=
d how some applications should adapt to it.<br>
They also do mention that the effective mempool cache size has changed, but=
 not that applications can restore the previously 50 % larger effective cac=
he size by simply requesting a 50 % larger cache.<br>
<br>
Maybe we should move the notes about the mempool changes from the New Featu=
res section to the API Changes section, and mention how to increase the cac=
he size to regain the reduction in effective size?<br>
<br>
[1]: <a href=3D"https://github.com/DPDK/dpdk/blob/v26.07-rc4/doc/guides/rel=
_notes/release_26_07.rst?plain=3D1#L80" rel=3D"noreferrer" target=3D"_blank=
">https://github.com/DPDK/dpdk/blob/v26.07-rc4/doc/guides/rel_notes/release=
_26_07.rst?plain=3D1#L80</a><br>
<br>
&gt; <br>
&gt; On the other hand, in realworld, i.e. not just testpmd/l3fwd cases<br>
&gt; doing<br>
&gt; little packet processesing, I would be fairly hopeful that regressions=
<br>
&gt; are<br>
&gt; going to be few and very small.<br>
<br>
Yes.<br>
And some real world applications (most run-to-completion applications?) wil=
l get fewer mempool cache misses with the new algorithm.<br>
Best case a performance improvement exceeding the performance cost of the r=
educed effective cache size.<br>
<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Please also note that the current implementation is carefully<br>
&gt; designed to keep the transfers to/from the mempool backend CPU cache<b=
r>
&gt; aligned (assuming cache-&gt;size is 2^N and large enough).<br>
&gt; &gt; Refer to the parameters passed to<br>
&gt; rte_mempool_ops_enqueue/dequeue_bulk().<br>
&gt; &gt; E.g. with mempool cache size 256, backend transfers are 128 objec=
ts,<br>
&gt; 16 full cache lines.<br>
&gt; &gt; Using CPU cache aligned transfers has a few advantages:<br>
&gt; &gt; - There are no cache line ownership issues across different CPU c=
ores<br>
&gt; repeatedly accessing the backend.<br>
&gt; &gt; - The mempool backend drivers can be performance optimized for<br=
>
&gt; transferring full CPU cache lines. (Both source and destination<br>
&gt; addresses, and number of objects copied, are CPU cache aligned.<br>
&gt; Assuming all transfers go via the mempool cache.)<br>
&gt; &gt;<br>
&gt; &gt; These details should be fine tuned in the implementation, if we d=
o<br>
&gt; proceed with Bruce&#39;s algorithm.<br>
&gt; &gt;<br>
&gt; Yep, good points.<br>
&gt; <br>
&gt; /Bruce<br>
<br></blockquote><div>Sounds good. Documenting the limitation helps.</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
PS:<br>
I have some API/ABI breaking mempool optimizations in the pipeline for DPDK=
 26.11.<br>
But let&#39;s try to concentrate on DPDK 26.07 for now. ;-)<br>
<br>
</blockquote></div></div>

--000000000000e3607b06571523a6--

--000000000000f3e0a30657152328
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVcQYJKoZIhvcNAQcCoIIVYjCCFV4CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLeMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGpzCCBI+g
AwIBAgIMTxuM8PbwRQIs9uJeMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTIxOFoXDTI3MDYyMTEzNTIxOFowgekxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzETMBEGA1UEBBMKUGFkbWFuYWJoYTEQMA4GA1UEKhMHS2lzaG9yZTEWMBQGA1UEChMNQlJP
QURDT00gSU5DLjEoMCYGA1UEAwwfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTEuMCwG
CSqGSIb3DQEJARYfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBALtFWP+ax39qiJZsJuukdoqMyp0GWGaJ6MdaHvAxXWiEY5zmTiVU
QnpmNYp5SO1Cd1cBqDB0dcelQbiQ1qh+lnlUchJLR63y0ysUvUNvqV493q8+pHCm/2jPb0/R9rec
/jxwM9jaPAVkhGBwvudSfOAQlMPORtAHZyLHKFINcsNfLrGP/3lx+zj30v5tmDN7isOLWos7Jm/U
qRdC7UuUiXgX7q8xXd1MQlA95O73IY/Qb/y0ChEjGPb+U1wr+OsAWJ5fcjQXA/ffBb2GmMp9OUOs
wVNq8iHfie9nzNaaRw+yoyn0ovoiq2W3Q6r+U53ha/lz0itqCrJZN+G0MFf+cX8CAwEAAaOCAeMw
ggHfMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggr
BgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1l
Y2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2Ny
NnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGg
MgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5
LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWlt
ZWNhMjAyMy5jcmwwKgYDVR0RBCMwIYEfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTAT
BgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNV
HQ4EFgQURIyot+ZP/mdwQsofZexqAvOm5pMwDQYJKoZIhvcNAQELBQADggIBAKc5gYnhyTf+f6cm
kAHy1a4cLIWou43yaS+M/r69Pv44EVYvHxqt0mMvKh3U40Y+pHKph+VCjdoINKCd1SaqAFIqqEO4
XHWrFi3QAI3snUB6spPIoHN/srAcpX9tdrnAlyK593pq+H+mTMoFIGBP/oc8XCtaDgHp37rpuK9Q
qhF9h5cEJWgShmD7/Q02YydW3jsioy8HdTUD9fib1fRwiSc9uGq8JV5NJsYiJsi9FUz7kTUPohO0
h6U9tRUVmAf9gPbU46rin9By5X4Lt1jKge5O0vFEawCTr/pLmDcIf7CqRZfBoNalKOsBDovoeAOf
pXmQzQEMhnaf93MvbFvZaxC9Ir92DR45BH42xZuLKcQVUsqyLKwC6kEZg81AnZsRAUVpMvqiGbVb
hZnabsHragNY7Br3VCA2OaWk9yRRjt1UwzfIEEMNWqZeQzzAqKIR3XdXIrqAUlMQOX42tSV9FaIv
PSmR3uaH2M0/bRtz4TE1qRuTsLlr+XEGMxHssK7u7+WYM7EGF3ueZLcE7WmnwXEFli5Y5QX0SnmT
W8uDQvdvRdxXg4lkBLyifOudYTP3fULjpD6RWQPFlUPlh8F5QQEdKlfKW94rGD+O0u4sWi/msZw0
6VTvZ6C2BbUMJAo7coFff48NkW2xfICC8Kn1eU1eiWCrPSAls8STm9q25wOQMYICVzCCAlMCAQEw
YjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xv
YmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMTxuM8PbwRQIs9uJeMA0GCWCGSAFlAwQCAQUA
oIHHMC8GCSqGSIb3DQEJBDEiBCAyWtVQnR5RZYtQpYahMiqtPYFCztLPP2fK+IcIgquEZTAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA3MjEwMTQyNDlaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAQTdWOdupX
xsbY+CIh4s9tUYCbNlJug8AWGb+2JFM0zk8L76BzmLBW/pNb5GB1TcdfJGw6lm+XzwRqKx5TBszk
uG+zfrV18NVmZVWl+yC9drC6lMFGpF/zORXvAWKNvAzzrFCjoJ49zazo1Or1i84Gy1J2UJcQ4Bk7
nXvpKrVQxdvtivIxOSk7YyGSPRFEzHr8CC4yFppe9hKcdZtkom6HZr66tDYBnzPLz+8RORGOLWK7
OJ42YFT1Mi2l0ehhg9+nH+5GSpn/pleM4zl8b3ivQ29K8nnZB9vvW1kTmgqPICx15KvmVmxrVVXY
8fMFuIv3BnBuQQuLjl5U04A28FxZ
--000000000000f3e0a30657152328--
