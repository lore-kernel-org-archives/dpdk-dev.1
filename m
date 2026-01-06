Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE93C47BE0
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 10:40:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7D21402DC;
	Tue,  6 Jan 2026 11:40:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A36C2400EF
 for <dev@dpdk.org>; Tue,  6 Jan 2026 11:40:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767696055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g0LZjJXFCBzpX3QIfnHTAnBmMgl6i1nIYT4ZZhjd1K0=;
 b=NKHzj3YMiD9G60riMP59Nr/YS4vG+1TYnNPabJ7x+/K21oQPInwnqy63dMMeK6X6LuXZc+
 ahmECIrF5d7FIaK4HGCMToxcnMVGKI4xbFqzal+ORaH6g/J7pfTPZir6Lbqa0LMs/hmjdK
 kzdSEzDP8i1alKpj2WNvhRQzXbR0jkI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-ExH_vMyGMwqEsD2OOcmHqQ-1; Tue, 06 Jan 2026 05:40:53 -0500
X-MC-Unique: ExH_vMyGMwqEsD2OOcmHqQ-1
X-Mimecast-MFC-AGG-ID: ExH_vMyGMwqEsD2OOcmHqQ_1767696052
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5959d533486so589720e87.1
 for <dev@dpdk.org>; Tue, 06 Jan 2026 02:40:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767696052; x=1768300852;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g0LZjJXFCBzpX3QIfnHTAnBmMgl6i1nIYT4ZZhjd1K0=;
 b=FAnPlY3VeF2kJe7rBJRiR4Me5pSTfk2qhVA8NMmTw8v+6Yk2tz2eegaOsVC/9kPm+X
 76DLUoRhGhVRLLg8NH6CTp5k5Vx5sAsSxE9g3+SL4dOt0irV224C3cx4RoDRJJTiL69Y
 wtf6MZcXe3z53MZoG5revaWn67UYRY/u+Evqq3Qo73FTqrlSbBKqCakW6XLm4G5dCEoZ
 n7c6lTEIij8C4LTYNO2LkHRrIPWZLbRkKJpQhNGT3tH2A3fJU4QVd8UiAZdtyzM2RcU2
 NsjhIPhtX6tZ1HNlWGv12K6pztpy7luhKeEasgeRrCgXRHXlKl70ui4n/d6Eh2iCIKTd
 iDiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw8GyxWhGEpPTw0FzenDirfJ0ZmYsfDaUrZWa/EY1esXkpVXZPrQhVu9QuxOSzvygQOlc=@dpdk.org
X-Gm-Message-State: AOJu0YwDyjbh+s6m16N8eLstx0P4E4hHz47at0PjS92CsNenuV4i1alj
 X/1+odCjCoxkLe1Ahz6CuCi+Dky4BgeIu7dYYQ1w15W70owAnW0V4GiGiEcJFffmkMKGJW3CxpK
 ZiNdQ2qJcq0EphE+2zs+HITZpXoxSzv9y62sX6UtLQtwvWnURqJ2IvOsQ9xsFF/qRONLS4goPJz
 QQKHDxfgRCX5ZoiHnE+/Q=
X-Gm-Gg: AY/fxX7LtdKcWBIhKZWwhIDTRYRJ9IaxTZNDfSN/5eL6DQ8uE3/EnJFIemfDsXh6eOo
 wa73XEZxk47MeanL/3wzBKLCfja92ifJiNrdRA+DC+wxkscGO1rDbvzmZoBfrVPKTPhheEHjtZ4
 UYMA+lWD3NykXO11z3YHdh2H6CBWBSoungoxiZF1d/De79fkWkBzBx7bBUJJjyCFvJbYABhdp0E
 UNX4j8T6OKWD7AIDpasm3RKIawa+Em/S3/8u6K3hTFAxX+RoUMpmw==
X-Received: by 2002:a05:6512:10c5:b0:577:318a:a1c6 with SMTP id
 2adb3069b0e04-59b6529332fmr874597e87.23.1767696051721; 
 Tue, 06 Jan 2026 02:40:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2macpRILP30ihtB7xAH+KOrNNCs+KXwP+qsp4hnypOaEJRj+QJ2E0RmSc0Own4EABHnXHKN8prRKHQ9Djgdk=
X-Received: by 2002:a05:6512:10c5:b0:577:318a:a1c6 with SMTP id
 2adb3069b0e04-59b6529332fmr874587e87.23.1767696050942; Tue, 06 Jan 2026
 02:40:50 -0800 (PST)
MIME-Version: 1.0
References: <553996$6i5mrh@smtpauth.intel.com>
 <SJ0PR19MB4606FAC1A477B65FC4AF1CEBF5D1A@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <SJ0PR19MB46061E7A91AEF354663CD827F5A3A@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <SJ0PR19MB46060E3FBC2D4E7B0FD4BCCFF5ADA@SJ0PR19MB4606.namprd19.prod.outlook.com>
In-Reply-To: <SJ0PR19MB46060E3FBC2D4E7B0FD4BCCFF5ADA@SJ0PR19MB4606.namprd19.prod.outlook.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Tue, 6 Jan 2026 11:40:40 +0100
X-Gm-Features: AQt7F2rTc6urefZirH-pZutvuSgZhuo_XvgFDXX8RpNJljuxczC91_48GzilIZI
Message-ID: <CAO55csy0QDUVdgs7ezRJuf9hD6gkwTvCd6zhHXj2xTwRpdgO5Q@mail.gmail.com>
Subject: Re: |Smoke |FAILURE| pw(158765-158768) sid(36689)
 job(PER_PATCH_BUILD17274-20251113210704)
 [v5,4/4] vhost_user: Function defs for add/rem mem regions
To: "Bathija, Pravin" <Pravin.Bathija@dell.com>
Cc: fengchengwen <fengchengwen@huawei.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, 
 "dev@dpdk.org" <dev@dpdk.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BQTiZGKbH-j3UNBUfKuCSENJn3QKSAQqsC541tiUSL8_1767696052
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000300b590647b5cf9b"
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

--000000000000300b590647b5cf9b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pravin,

It seems you didn't put me in copy of the v5 revision.
Could you please resend the v5 with following the submission process as
documented in the DPDK documentation?

Best regards,
Maxime

On Mon, Dec 15, 2025 at 9:29=E2=80=AFAM Bathija, Pravin <Pravin.Bathija@del=
l.com>
wrote:

> Hello again Fengcheng, Maxime,
>
> Any thoughts on when my changes will be merged into dpdk mainline ? Some
> of the SPDK test suites we plan to merge are dependent on this change.
> Please provide your input at your earliest convenience.
>
> Regards,
> Pravin
>
>
> Internal Use - Confidential
> > -----Original Message-----
> > From: Bathija, Pravin
> > Sent: Tuesday, December 9, 2025 1:06 AM
> > To: 'fengchengwen' <fengchengwen@huawei.com>; 'Maxime Coquelin'
> > <maxime.coquelin@redhat.com>; 'dev@dpdk.org' <dev@dpdk.org>
> > Subject: RE: |Smoke |FAILURE| pw(158765-158768) sid(36689)
> > job(PER_PATCH_BUILD17274-20251113210704) [v5,4/4] vhost_user: Function
> > defs for add/rem mem regions
> >
> > Dear Fencheng, Maxime,
> >
> > Gentle reminder to check-in when my changes will be merged ?
> >
> > Thanks,
> > Pravin
> >
> > > -----Original Message-----
> > > From: Bathija, Pravin
> > > Sent: Monday, November 24, 2025 11:24 PM
> > > To: fengchengwen <fengchengwen@huawei.com>; Maxime Coquelin
> > > <maxime.coquelin@redhat.com>; dev@dpdk.org
> > > Subject: FW: |Smoke |FAILURE| pw(158765-158768) sid(36689)
> > > job(PER_PATCH_BUILD17274-20251113210704) [v5,4/4] vhost_user:
> > Function
> > > defs for add/rem mem regions
> > >
> > > Dear Fengcheng, Maxime,
> > >
> > > When I look at the test results below, I see that one of the tests
> > > "test_checksum_offload_with_vlan" failed. However, when I navigate to
> > > the actual test results page - that same test shows passed. Could you
> > > please share your thoughts on this ?
> > >
> > > https://mails.dpdk.org/archives/test-report/2025-November/931175.html
> > >
> > > Also, any thoughts on when my code will be merged to mainline ?
> > >
> > > Regards,
> > > Pravin
> > >
> > >
> > > -----Original Message-----
> > > From: sys_stv@intel.com <sys_stv@intel.com>
> > > Sent: Thursday, November 13, 2025 9:48 AM
> > > To: test-report@dpdk.org; Bathija, Pravin <Pravin.Bathija@dell.com>
> > > Cc: daxuex.gao@intel.com
> > > Subject: |Smoke |FAILURE| pw(158765-158768) sid(36689)
> > > job(PER_PATCH_BUILD17274-20251113210704) [v5,4/4] vhost_user:
> > Function
> > > defs for add/rem mem regions
> > >
> > >
> > > [EXTERNAL EMAIL]
> > >
> > >
> > > Test-Label: intel-Functional
> > > Test-Status: FAILURE
> > > https://urldefense.com/v3/__http://dpdk.org/patch/158768__;!!LpKI!jCH=
b
> > > Wx
> > > KxAWgIg6OQEvPP3-yCEWdKOlDUFrlDl-
> > > Njivh4rgNkJqRj9YFVVY9hRHocrV4lnvkjjvMMC85WVA$ [dpdk[.]org]
> > >
> > > _Functional issues_
> > >
> > > Submitter: Pravin M Bathija <pravin.bathija@dell.com>
> > > Date: 2025-11-13 12:44:22
> > > Branch : dpdk-next-virtio
> > > CommitID: 6b37c26a95
> > >
> > > Smoke-Testing Summary : 31 Case Done, 30 Successful, 1 Failures
> > >
> > >
> > > OS : Ubuntu 24.04.3 LTS
> > > Kernel : 6.8.0-71-generic
> > > GCC : 13.3.0-6ubuntu2~24.04
> > > NIC : Ethernet Controller XL710 for 40GbE QSFP+ Target :
> > > x86_64-native-linuxapp-gcc
> > >
> > >     Test result details:
> > >
>  +-----------------+---------------------------------------------------+-=
------+
> > >     | suite           | case
>     | status|
> > >
>  +-----------------+---------------------------------------------------+-=
------+
> > >     | checksum_offload|
> > > test_do_not_insert_checksum_on_the_transmit_packet| passed|
> > >     | checksum_offload| test_hardware_checksum_check_ip_rx
>     |
> > > passed|
> > >     | checksum_offload| test_hardware_checksum_check_ip_tx
>     |
> > > passed|
> > >     | checksum_offload| test_hardware_checksum_check_l4_rx
>     |
> > > passed|
> > >     | checksum_offload| test_insert_checksum_on_the_transmit_packet
> > > | passed|
> > >     | checksum_offload| test_rx_checksum_valid_flags
>     |
> > > passed|
> > >     | checksum_offload| test_checksum_offload_with_vlan
>    |
> > > FAILED|
> > >     | checksum_offload| test_hardware_checksum_check_l4_tx
>     |
> > > n/a   |
> > >     | dual_vlan       | test_dual_vlan_priority_rxtx
>     | passed|
> > >     | dual_vlan       | test_vlan_filter_config
>    | passed|
> > >     | dual_vlan       | test_vlan_filter_table
>     | passed|
> > >     | dual_vlan       | test_vlan_insert_config
>    | passed|
> > >     | dual_vlan       | test_vlan_random_test
>    | passed|
> > >     | dual_vlan       | test_vlan_strip_config
>     | passed|
> > >     | dual_vlan       | test_vlan_synthetic_test
>     | passed|
> > >     | dual_vlan       | test_vlan_tpid_config
>    | passed|
> > >     | dual_vlan       | test_vlan_stripq_config
>    | n/a   |
> > >     | jumboframes     | test_jumboframes_bigger_jumbo
>    |
> > > passed|
> > >     | jumboframes     | test_jumboframes_jumbo_jumbo
>     |
> > > passed|
> > >     | jumboframes     | test_jumboframes_jumbo_nojumbo
>     |
> > > passed|
> > >     | jumboframes     | test_jumboframes_normal_jumbo
>    |
> > > passed|
> > >     | jumboframes     | test_jumboframes_normal_nojumbo
>    |
> > > passed|
> > >     | rxtx_offload    | test_rxoffload_port_all
>    | passed|
> > >     | rxtx_offload    | test_rxoffload_port_cmdline
>    | passed|
> > >     | rxtx_offload    | test_txoffload_port
>    | passed|
> > >     | rxtx_offload    | test_txoffload_port_all
>    | passed|
> > >     | rxtx_offload    | test_txoffload_port_checksum
>     | passed|
> > >     | rxtx_offload    | test_txoffload_port_cmdline
>    | passed|
> > >     | rxtx_offload    | test_txoffload_port_multi_segs
>     | passed|
> > >     | rxtx_offload    | test_txoffload_queue
>     | passed|
> > >     | rxtx_offload    | test_rxoffload_queue
>     | n/a   |
> > >
> > > +-----------------+--------------------------------------------------=
-
> > > +-------+
> > >
> > >
> > > DPDK STV team
>
>

--000000000000300b590647b5cf9b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Pravin,</div><div><br></div><div>It seems you didn=
&#39;t put me in copy of the v5 revision.</div><div>Could you please resend=
 the v5 with following the submission process as documented in the DPDK doc=
umentation?</div><div><br></div><div>Best regards,</div><div>Maxime</div></=
div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Mon, Dec 15, 2025 at 9:29=E2=80=AFAM Bathija, Pravin=
 &lt;<a href=3D"mailto:Pravin.Bathija@dell.com">Pravin.Bathija@dell.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hell=
o again Fengcheng, Maxime,<br>
<br>
Any thoughts on when my changes will be merged into dpdk mainline ? Some of=
 the SPDK test suites we plan to merge are dependent on this change. Please=
 provide your input at your earliest convenience.<br>
<br>
Regards,<br>
Pravin<br>
<br>
<br>
Internal Use - Confidential<br>
&gt; -----Original Message-----<br>
&gt; From: Bathija, Pravin<br>
&gt; Sent: Tuesday, December 9, 2025 1:06 AM<br>
&gt; To: &#39;fengchengwen&#39; &lt;<a href=3D"mailto:fengchengwen@huawei.c=
om" target=3D"_blank">fengchengwen@huawei.com</a>&gt;; &#39;Maxime Coquelin=
&#39;<br>
&gt; &lt;<a href=3D"mailto:maxime.coquelin@redhat.com" target=3D"_blank">ma=
xime.coquelin@redhat.com</a>&gt;; &#39;<a href=3D"mailto:dev@dpdk.org" targ=
et=3D"_blank">dev@dpdk.org</a>&#39; &lt;<a href=3D"mailto:dev@dpdk.org" tar=
get=3D"_blank">dev@dpdk.org</a>&gt;<br>
&gt; Subject: RE: |Smoke |FAILURE| pw(158765-158768) sid(36689)<br>
&gt; job(PER_PATCH_BUILD17274-20251113210704) [v5,4/4] vhost_user: Function=
<br>
&gt; defs for add/rem mem regions<br>
&gt;<br>
&gt; Dear Fencheng, Maxime,<br>
&gt;<br>
&gt; Gentle reminder to check-in when my changes will be merged ?<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Pravin<br>
&gt;<br>
&gt; &gt; -----Original Message-----<br>
&gt; &gt; From: Bathija, Pravin<br>
&gt; &gt; Sent: Monday, November 24, 2025 11:24 PM<br>
&gt; &gt; To: fengchengwen &lt;<a href=3D"mailto:fengchengwen@huawei.com" t=
arget=3D"_blank">fengchengwen@huawei.com</a>&gt;; Maxime Coquelin<br>
&gt; &gt; &lt;<a href=3D"mailto:maxime.coquelin@redhat.com" target=3D"_blan=
k">maxime.coquelin@redhat.com</a>&gt;; <a href=3D"mailto:dev@dpdk.org" targ=
et=3D"_blank">dev@dpdk.org</a><br>
&gt; &gt; Subject: FW: |Smoke |FAILURE| pw(158765-158768) sid(36689)<br>
&gt; &gt; job(PER_PATCH_BUILD17274-20251113210704) [v5,4/4] vhost_user:<br>
&gt; Function<br>
&gt; &gt; defs for add/rem mem regions<br>
&gt; &gt;<br>
&gt; &gt; Dear Fengcheng, Maxime,<br>
&gt; &gt;<br>
&gt; &gt; When I look at the test results below, I see that one of the test=
s<br>
&gt; &gt; &quot;test_checksum_offload_with_vlan&quot; failed. However, when=
 I navigate to<br>
&gt; &gt; the actual test results page - that same test shows passed. Could=
 you<br>
&gt; &gt; please share your thoughts on this ?<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"https://mails.dpdk.org/archives/test-report/2025-Novem=
ber/931175.html" rel=3D"noreferrer" target=3D"_blank">https://mails.dpdk.or=
g/archives/test-report/2025-November/931175.html</a><br>
&gt; &gt;<br>
&gt; &gt; Also, any thoughts on when my code will be merged to mainline ?<b=
r>
&gt; &gt;<br>
&gt; &gt; Regards,<br>
&gt; &gt; Pravin<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; -----Original Message-----<br>
&gt; &gt; From: <a href=3D"mailto:sys_stv@intel.com" target=3D"_blank">sys_=
stv@intel.com</a> &lt;<a href=3D"mailto:sys_stv@intel.com" target=3D"_blank=
">sys_stv@intel.com</a>&gt;<br>
&gt; &gt; Sent: Thursday, November 13, 2025 9:48 AM<br>
&gt; &gt; To: <a href=3D"mailto:test-report@dpdk.org" target=3D"_blank">tes=
t-report@dpdk.org</a>; Bathija, Pravin &lt;<a href=3D"mailto:Pravin.Bathija=
@dell.com" target=3D"_blank">Pravin.Bathija@dell.com</a>&gt;<br>
&gt; &gt; Cc: <a href=3D"mailto:daxuex.gao@intel.com" target=3D"_blank">dax=
uex.gao@intel.com</a><br>
&gt; &gt; Subject: |Smoke |FAILURE| pw(158765-158768) sid(36689)<br>
&gt; &gt; job(PER_PATCH_BUILD17274-20251113210704) [v5,4/4] vhost_user:<br>
&gt; Function<br>
&gt; &gt; defs for add/rem mem regions<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; [EXTERNAL EMAIL]<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Test-Label: intel-Functional<br>
&gt; &gt; Test-Status: FAILURE<br>
&gt; &gt; <a href=3D"https://urldefense.com/v3/__http://dpdk.org/patch/1587=
68__;!!LpKI!jCHb" rel=3D"noreferrer" target=3D"_blank">https://urldefense.c=
om/v3/__http://dpdk.org/patch/158768__;!!LpKI!jCHb</a><br>
&gt; &gt; Wx<br>
&gt; &gt; KxAWgIg6OQEvPP3-yCEWdKOlDUFrlDl-<br>
&gt; &gt; Njivh4rgNkJqRj9YFVVY9hRHocrV4lnvkjjvMMC85WVA$ [dpdk[.]org]<br>
&gt; &gt;<br>
&gt; &gt; _Functional issues_<br>
&gt; &gt;<br>
&gt; &gt; Submitter: Pravin M Bathija &lt;<a href=3D"mailto:pravin.bathija@=
dell.com" target=3D"_blank">pravin.bathija@dell.com</a>&gt;<br>
&gt; &gt; Date: 2025-11-13 12:44:22<br>
&gt; &gt; Branch : dpdk-next-virtio<br>
&gt; &gt; CommitID: 6b37c26a95<br>
&gt; &gt;<br>
&gt; &gt; Smoke-Testing Summary : 31 Case Done, 30 Successful, 1 Failures<b=
r>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; OS : Ubuntu 24.04.3 LTS<br>
&gt; &gt; Kernel : 6.8.0-71-generic<br>
&gt; &gt; GCC : 13.3.0-6ubuntu2~24.04<br>
&gt; &gt; NIC : Ethernet Controller XL710 for 40GbE QSFP+ Target :<br>
&gt; &gt; x86_64-native-linuxapp-gcc<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Test result details:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0+-----------------+---------------------------=
------------------------+-------+<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| suite=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| case=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | status|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0+-----------------+---------------------------=
------------------------+-------+<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| checksum_offload|<br>
&gt; &gt; test_do_not_insert_checksum_on_the_transmit_packet| passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| checksum_offload| test_hardware_checksum_che=
ck_ip_rx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
&gt; &gt; passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| checksum_offload| test_hardware_checksum_che=
ck_ip_tx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
&gt; &gt; passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| checksum_offload| test_hardware_checksum_che=
ck_l4_rx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
&gt; &gt; passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| checksum_offload| test_insert_checksum_on_th=
e_transmit_packet<br>
&gt; &gt; | passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| checksum_offload| test_rx_checksum_valid_fla=
gs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |<br>
&gt; &gt; passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| checksum_offload| test_checksum_offload_with=
_vlan=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
<br>
&gt; &gt; FAILED|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| checksum_offload| test_hardware_checksum_che=
ck_l4_tx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
&gt; &gt; n/a=C2=A0 =C2=A0|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| dual_vlan=C2=A0 =C2=A0 =C2=A0 =C2=A0| test_d=
ual_vlan_priority_rxtx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| dual_vlan=C2=A0 =C2=A0 =C2=A0 =C2=A0| test_v=
lan_filter_config=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| dual_vlan=C2=A0 =C2=A0 =C2=A0 =C2=A0| test_v=
lan_filter_table=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| dual_vlan=C2=A0 =C2=A0 =C2=A0 =C2=A0| test_v=
lan_insert_config=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| dual_vlan=C2=A0 =C2=A0 =C2=A0 =C2=A0| test_v=
lan_random_test=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| dual_vlan=C2=A0 =C2=A0 =C2=A0 =C2=A0| test_v=
lan_strip_config=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| dual_vlan=C2=A0 =C2=A0 =C2=A0 =C2=A0| test_v=
lan_synthetic_test=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| dual_vlan=C2=A0 =C2=A0 =C2=A0 =C2=A0| test_v=
lan_tpid_config=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| dual_vlan=C2=A0 =C2=A0 =C2=A0 =C2=A0| test_v=
lan_stripq_config=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| n/a=C2=A0 =C2=A0|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| jumboframes=C2=A0 =C2=A0 =C2=A0| test_jumbof=
rames_bigger_jumbo=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|<br>
&gt; &gt; passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| jumboframes=C2=A0 =C2=A0 =C2=A0| test_jumbof=
rames_jumbo_jumbo=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |<br>
&gt; &gt; passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| jumboframes=C2=A0 =C2=A0 =C2=A0| test_jumbof=
rames_jumbo_nojumbo=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |<br>
&gt; &gt; passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| jumboframes=C2=A0 =C2=A0 =C2=A0| test_jumbof=
rames_normal_jumbo=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|<br>
&gt; &gt; passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| jumboframes=C2=A0 =C2=A0 =C2=A0| test_jumbof=
rames_normal_nojumbo=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|<br>
&gt; &gt; passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| rxtx_offload=C2=A0 =C2=A0 | test_rxoffload_p=
ort_all=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| rxtx_offload=C2=A0 =C2=A0 | test_rxoffload_p=
ort_cmdline=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| rxtx_offload=C2=A0 =C2=A0 | test_txoffload_p=
ort=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| rxtx_offload=C2=A0 =C2=A0 | test_txoffload_p=
ort_all=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| rxtx_offload=C2=A0 =C2=A0 | test_txoffload_p=
ort_checksum=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| rxtx_offload=C2=A0 =C2=A0 | test_txoffload_p=
ort_cmdline=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| rxtx_offload=C2=A0 =C2=A0 | test_txoffload_p=
ort_multi_segs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| rxtx_offload=C2=A0 =C2=A0 | test_txoffload_q=
ueue=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | passed|<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0| rxtx_offload=C2=A0 =C2=A0 | test_rxoffload_q=
ueue=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | n/a=C2=A0 =C2=A0|<br>
&gt; &gt;<br>
&gt; &gt; +-----------------+----------------------------------------------=
-----<br>
&gt; &gt; +-------+<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; DPDK STV team<br>
<br>
</blockquote></div>

--000000000000300b590647b5cf9b--

