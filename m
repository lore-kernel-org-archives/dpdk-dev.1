Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D5AC44502
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 09:46:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F3224026C;
	Wed, 21 Jan 2026 10:46:18 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 84A86400D7;
 Wed, 21 Jan 2026 10:46:16 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dwzpP2nrtzJ469d;
 Wed, 21 Jan 2026 17:45:49 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id 4DDA240569;
 Wed, 21 Jan 2026 17:46:15 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500004.china.huawei.com (7.182.19.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Jan 2026 10:46:15 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 21 Jan 2026 10:46:15 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Lukas Sismis <sismis@dyna-nic.com>, "dts@dpdk.org" <dts@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "dmarx@iol.unh.edu" <dmarx@iol.unh.edu>,
 "abailey@iol.unh.edu" <abailey@iol.unh.edu>
Subject: RE: [PATCH v1 1/1] dts: fix invalid f-string syntax in testpmd API
Thread-Topic: [PATCH v1 1/1] dts: fix invalid f-string syntax in testpmd API
Thread-Index: AQHcimG90CMIbYUeGkytw6knKhE0IbVcX6+Q
Date: Wed, 21 Jan 2026 09:46:15 +0000
Message-ID: <edeabad0cfe7460d82be2d9673b7ad9b@huawei.com>
References: <20260120230806.192421-1-sismis@dyna-nic.com>
 <20260120230806.192421-2-sismis@dyna-nic.com>
In-Reply-To: <20260120230806.192421-2-sismis@dyna-nic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.70]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

> -----Original Message-----
> From: Lukas Sismis <sismis@dyna-nic.com>
> Sent: Tuesday 20 January 2026 23:08
> To: dts@dpdk.org
> Cc: dev@dpdk.org; dmarx@iol.unh.edu; abailey@iol.unh.edu; Lukas Sismis <s=
ismis@dyna-nic.com>
> Subject: [PATCH v1 1/1] dts: fix invalid f-string syntax in testpmd API
>=20
> Fix f-string syntax errors where double quotes were nested inside
> f-strings that also use double quotes as delimiters.
> ---
>  dts/api/testpmd/__init__.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
> index a20dedc25a..703cae487e 100644
> --- a/dts/api/testpmd/__init__.py
> +++ b/dts/api/testpmd/__init__.py
> @@ -227,7 +227,7 @@ def start_tx_first(self, burst_num: int, verify: bool=
 =3D True) -> None:
>              InteractiveCommandExecutionError: If `verify` is :data:`True=
` and forwarding fails to
>                  start or ports fail to come up.
>          """
> -        self.send_command(f"start tx_first {burst_num if burst_num is no=
t None else ""}")
> +        self.send_command(f"start tx_first {burst_num if burst_num is no=
t None else ''}")
>          if verify:
>              # If forwarding was already started, sending "start" again s=
hould tell us
>              start_cmd_output =3D self.send_command("start")
> @@ -898,11 +898,11 @@ def set_qinq_strip(self, port: int, enable: bool, v=
erify: bool =3D True) -> None:
>              vlan_settings =3D self.show_port_info(port_id=3Dport).vlan_o=
ffload
>              if enable ^ (vlan_settings is not None and VLANOffloadFlag.Q=
INQ_STRIP in vlan_settings):
>                  self._logger.debug(
> -                    f"Failed to {"enable" if enable else "disable"}"
> +                    f"Failed to {'enable' if enable else 'disable'}"
>                      f"QinQ strip on port {port}: \n{qinq_cmd_output}"
>                  )
>                  raise InteractiveCommandExecutionError(
> -                    f"Failed to {"enable" if enable else "disable"} QinQ=
 strip on port {port}"
> +                    f"Failed to {'enable' if enable else 'disable'} QinQ=
 strip on port {port}"
>                  )
>=20
>      def set_mac_address(self, port: int, mac_address: str, verify: bool =
=3D True) -> None:
> @@ -1535,7 +1535,7 @@ def set_port_mbuf_fast_free(
>              InteractiveCommandExecutionError: If mbuf_fast_free could no=
t be set successfully.
>          """
>          mbuf_output =3D self.send_command(
> -            f"port config {port_id} tx_offload mbuf_fast_free {"on" if o=
n else "off"}"
> +            f"port config {port_id} tx_offload mbuf_fast_free {'on' if o=
n else 'off'}"
>          )
>=20
>          if verify and "Error" in mbuf_output:
> --
> 2.43.7

Acked-by: Marat Khalili <marat.khalili@huawei.com>

Thank you, this noise in the compile logs was a bit annoying. I have to ask=
=20
however, how did it pass? Are we ignoring some errors?
