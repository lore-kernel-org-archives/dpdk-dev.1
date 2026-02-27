Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C0CFEFB77
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 18:36:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AF8F402E7;
	Fri, 27 Feb 2026 19:36:11 +0100 (CET)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 818DA402C6
 for <dev@dpdk.org>; Fri, 27 Feb 2026 19:36:09 +0100 (CET)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2bdbd13ca01so4301139eec.0
 for <dev@dpdk.org>; Fri, 27 Feb 2026 10:36:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772217368; cv=none;
 d=google.com; s=arc-20240605;
 b=XCdAK3FeRt4FqtYoJhM4OpVn4vnWNHJBODO3lyYOqmgbqLoN1cBt7THmu47AEuELO4
 iiRTDgaqwtJJq1n7Ho5RgA67BkCVxZwh3fCN/u7WlDMy3JyejtWymqEAS3ej896QZ8Vg
 63PLBPh4hK+JHHg26mDw6gRsy0biwT0uCQ7wjMntCjS9+LXhLMJCtI1oCGB64Kx5SH6K
 eTYD9+Yyrq11D3TPIXvGLbVpR2Jvh2irm+lGkzzQbx4wWZWuKZYOWKm3d4sJQqBHxlQ0
 g5v7Q1/mGgnyAt89yr9W8SZVs5WDiKz2aRbzT6hLQC/AAvEP/RoPdUM58wTzSF9Ci3qR
 ZLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=juE8zorOrcoMRVQ4KhNTS3zN8BVb0xIj81gwVZw0jEg=;
 fh=eLUhPcdTwViIVwq22ojPhr2Ps5FSjeS7ZYvySgDAq5A=;
 b=WOm2xRB8OxIJ6pFEI3i/KXl+vJseZX/jSYGygl6/lNEG/x4lTmZ+RrDboFD5S/vsto
 vbc2VpiOd4295qTw79wuLUq7EGdw7YFu4nxuniD5TJ2H3OPqwL/ge6ii4u83Oli+iTAD
 JxF7wps8At8eM9UWWR+tR8I2hEDnjRaxQV71xGlImFfwg8JlxxUfTPQBIPAQlJHVeccD
 Rd31WLgTDtrr27Z/pz+c8QtdOEXpGpVZCaU6fhrNxwap7Ylc6ahp3BvjZI+iLywgaALU
 sLTSvNmbmJVEm0vUkWQFW+FbMrCKglKIoWoZFuWBwnYY2TXoTqHxn+Po7yy/g0hfBG5+
 JA9w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772217368; x=1772822168; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=juE8zorOrcoMRVQ4KhNTS3zN8BVb0xIj81gwVZw0jEg=;
 b=VL1fo2H7s2AOMR1n7N3Db5c1fA0DBozgl7ottOd5h+MSH6MRWRrqOM2VxB4AD4GCWj
 008WBwUTu4TUw6R+oF0OkzKtMx7z0TLghh2USCkiSEQ645Yv+q0ZILG6fH0B/v0EFkrI
 /icFFFa11cjAhMi2MdEZx5co775vvrGV65i8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772217368; x=1772822168;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=juE8zorOrcoMRVQ4KhNTS3zN8BVb0xIj81gwVZw0jEg=;
 b=LMy6/t3zix6pw7/Tvj0cWVH6HMUgr9/TCjaTnIpBC6D9ZufeH0kwhZni3rHvJ+4Xh0
 mvNs60MXwtVGuaBNAyP0OLDZI8k4yROGM8mw101KZ811Ru0yJ2pTTrlj3dPD44KeHqsT
 KJo7RXqFbK7Tdl5WY56ySnzTtPkxbeuZ4JN+fQkr7+/bKNwXT4P2nwIU5WwA0ySsG6kl
 S2xSFh85YizLv+znMUscoMMYHHG2VtiLu20GT7U2w42DvIsVlXbJM1BAvfZtvCTcaw7w
 WZsPABYfJrQQ9UfiqNLo7zci9bISoEZt0oijByJU/kOjzBspd0XASWtOZ3cIG+IQi99R
 DbAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3GrYR2P0A3CtTgy1eUd1fX8ex4ahmofZaQ2wCwrPP2TDIcxJwUPrVvX50Gb4lWlUOqxc=@dpdk.org
X-Gm-Message-State: AOJu0YydNWuJmfeTHWKeA8b4vqIVHggipVY6dtsJThgnaV5+R61wnolV
 uQucDtyQtcZAvyGFBfkeBH0HTz1r/TkNSjFVYQx2QDCAdoyEDo1Loa6XqRce7sX3a88bz7pU+K7
 yC+qiL41WrkeRTBpQTxl3xX993yUI9PTD0WUb0EF3LQ==
X-Gm-Gg: ATEYQzzgNuvLsnhXzvwMSffsiCezHnCZ8TEpN9Zm4UoQemnIwY8ZSexY75axYuQhV/B
 LOP8j7ZqiKcA9YOg7TmSX7Wjld8KkHuEENHPm0MV1IyadlJPIRvVHCpv6ipd5Vd0QryTOvbLEW7
 U3UbsVvjeR91C2eaqbQBAQp9sI3PCATJhLNisSjQIjanSP8vxX6agUFswqGonDBvfZcHogWFfeu
 ntpoI1qIvBJ5eRykhfnXpQos4gu+s4jgDx1hmgqW3az7+7wWBnhO+/8gIz60Cv32NHxK/Si2pd4
 NtAPeHRCEvVH012YHrsjtA8gIpgAyrR+oviZoXY1QTznmT2YvIjNTowmDo5e5lrG
X-Received: by 2002:a05:693c:300f:b0:2b7:2bbd:95ae with SMTP id
 5a478bee46e88-2bde1d6f227mr1462795eec.37.1772217368455; Fri, 27 Feb 2026
 10:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260213193539.103858-1-abailey@iol.unh.edu>
 <20260213193539.103858-6-abailey@iol.unh.edu>
In-Reply-To: <20260213193539.103858-6-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 27 Feb 2026 13:33:17 -0500
X-Gm-Features: AaiRm52sjipfBqlI749Wz_kIMo0d_mK_wzkkQPzvpqU6zakS-2Sr2G71hYLiZZI
Message-ID: <CAJvnSUC38DBfXpMMupxXsAmiHwES7q5yeKA7MQvS=tmYoGCd-g@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] dts: automate VFIO-PCI modprobe in node setup
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org, 
 "Ji, Kai" <kai.ji@intel.com>,
 Dharmik Jayesh Thakkar <dharmikjayesh.thakkar@arm.com>, 
 David Marchand <david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Feb 13, 2026 at 2:36=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:
>
> Currently, users must modprobe VFIO-PCI before running DTS when using a
> non-mellanox NIC. This patch automates the process on test run start up.
> In addition, if the SUT is expected to use a subset of a few QAT devices,
> VFIO-PCI must be loaded in a separate manner. This patch adds this
> distinction.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  dts/framework/testbed_model/linux_session.py | 24 ++++++++++++++++++++
>  dts/framework/testbed_model/os_session.py    |  4 ++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework=
/testbed_model/linux_session.py
> index 27a5f48ecf..a761ca11fe 100644
> --- a/dts/framework/testbed_model/linux_session.py
> +++ b/dts/framework/testbed_model/linux_session.py
> @@ -224,6 +224,30 @@ def devbind_script_path(self) -> PurePath:
>          """
>          raise InternalError("Accessed devbind script path before setup."=
)
>
> +    def load_vfio(self, pf_port: Port) -> None:
> +        """Overrides :meth:`~os_session.OSSession,load_vfio`."""
> +        cmd_result =3D self.send_command(f"lspci -nn -s {pf_port.pci}")
> +        device =3D re.search(r":([0-9a-fA-F]{4})\]", cmd_result.stdout)
> +        if device and device.group(1) in ["37c8", "0435", "19e2"]:
> +            self.send_command(
> +                "modprobe -r vfio_iommu_type1; modprobe -r vfio_pci",
> +                privileged=3DTrue,
> +            )
> +            self.send_command(
> +                "modprobe -r vfio_virqfd; modprobe -r vfio",
> +                privileged=3DTrue,
> +            )
> +            self.send_command(
> +                "modprobe vfio-pci disable_denylist=3D1 enable_sriov=3D1=
", privileged=3DTrue
> +            )
> +            self.send_command(
> +                "echo 1 | tee /sys/module/vfio/parameters/enable_unsafe_=
noiommu_mode",
> +                privileged=3DTrue,
> +            )
> +        else:
> +            self.send_command("modprobe vfio-pci")
> +        self.refresh_lshw()
> +
>      def create_crypto_vfs(self, pf_port: list[Port]) -> None:
>          """Overrides :meth:`~os_session.OSSession.create_crypto_vfs`.
>
> diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/te=
stbed_model/os_session.py
> index 2eeeea6967..4a4fc1f34a 100644
> --- a/dts/framework/testbed_model/os_session.py
> +++ b/dts/framework/testbed_model/os_session.py
> @@ -615,6 +615,10 @@ def configure_port_mtu(self, mtu: int, port: Port) -=
> None:
>              port: Port to set `mtu` on.
>          """
>
> +    @abstractmethod
> +    def load_vfio(self, pf_port: Port) -> None:
> +        """Load the vfio module according to the device type of the give=
n port."""
> +
>      @abstractmethod
>      def create_crypto_vfs(self, pf_ports: list[Port]) -> None:
>          """Creatues virtual functions for each port in 'pf_ports'.

typo

> --
> 2.50.1
>

Adding Dharmik and David since they were the ones interested in this
custom vfio-pci loading way back when I added the support to legacy
DTS a couple years ago. And also Kai Ji since he is QAT maintainer and
must be familiar with the custom vfio-pci loading requirement for QAT
8970 and other cards.

In DPDK, your individual patches need to be "non-breaking" if they are
applied in chronological order. I.e. if only patch 1 is applied
nothing breaks, if patches 1 and 2 are applied nothing breaks etc.
It's challenging but let's make a best effort to comply. In the case
of this patch, it breaks the rule since load_vfio() is called in the
2/5 patch but does not exist until this 5/5 patch. So, I think the
easiest fix would be to move this 5/5 patch to be in between the
current 1/5 and current 2/5 patch.

I think the content of the patch looks good otherwise. Let's make sure
we run the testsuites on the 8970 card to validate the correct
"custom" vfio-pci loading.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>
