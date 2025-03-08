Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D99C282EC
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Mar 2025 14:28:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B415F4025D;
	Sat,  8 Mar 2025 15:28:49 +0100 (CET)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 90A6340156
 for <dev@dpdk.org>; Sat,  8 Mar 2025 15:28:47 +0100 (CET)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2feb91a2492so4885989a91.2
 for <dev@dpdk.org>; Sat, 08 Mar 2025 06:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741444127; x=1742048927; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/urTuyFHBUdVpN2d9Ebw8Q6OS4o98ojqoSe0Nn0bkZo=;
 b=fVCEb/pykzEK7LYJh6U3Nz6Gzmryo8hRrTcl7PnSGIdeQIqsmxsil0v6USBTTB6XCV
 9TTxDycLwMgJy/2iaJ2IbPapEMmt3VjIPQdOnBc/mdoWxeePDTw63W7GVN9W6efLECex
 jW3oSkpqQeWz/jAkiQeb2nRQ9zTJS0sLE10MGU5b/2w1RyDiVt7Eh9JH8p7H/lxHkTGh
 XVjs9ij6e7gPEmOSXV1dtbE9NdIX7R2qHxmVuQUsy4QoSEKH7uXad5roSGhKwYmuk/Zj
 v8M0UNtsUuQP+oEVlzLBcLOvnvgykGIUxIF7+WdDVfN47jYFOuRl5ucZzVl0WYsHP9E3
 nCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741444127; x=1742048927;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/urTuyFHBUdVpN2d9Ebw8Q6OS4o98ojqoSe0Nn0bkZo=;
 b=BbppDS55rvi9kL8qfyn5WTC3I68NHVzNxKRlutSVtX8oi8m4FpqwQh7uJY8nf+krKA
 8jJe4kG00Di8YolAT6BBd+3Qp6Vy8g9DUw18ezeIqGZsyvg8HaIcFgZfTd5uKOOHIpDY
 CGwiOoCgjdChQbXoXpTEa5U6q1XjY5oCmye7qtZgTR1h6G1SGttc7Bg0w3HCkpwWL7pM
 wmreoRtisXnmiVH+1XEXpAgUUzlRYSYJY+QlQQtKt5MKVACQ/bDzFu60kDzEhGj2YPG+
 OlqlzERnQS7zwSG8h0iIpqVykuqTza5Pq1N0eVJ767RfPgnSGpcQ3o0plaZfIqHaxvTo
 m0kg==
X-Gm-Message-State: AOJu0YzaECUsCPBCzMakSfRLgrFhdr+iYZ+vEdxZgK5mFtpnP19p3xKs
 z7XluBAM8Dhx1gIrdXzv2imBfYdrhMCzCwTfhn59HdJqagVoMtFEBqUj6gyhQ7302+eitdP9In0
 StXNJp8zdx/qnZaUxUvfcNZX1SGrAbInN
X-Gm-Gg: ASbGnctNyxK4uVHyoL9QllfxbM6ydiST+55mPvhbl49lrq9jC8AULP0tneOqTqUmlfe
 Ie2Riy171ZgF/ZLYggBBlrq567i0/C5kcL3/u4cTqYe1B0mtGA3zKHK7Mj7N232pNiA0PwqwSA5
 Hm6HMBBVe8IipzI1k1f8vvrAosrQQcQirjhJQ=
X-Google-Smtp-Source: AGHT+IG/83qgFQn8ZeiXnOreq+I4T+txFPYYxlgz46nPmDDN9NTh6xidWCBJL6/dyNlpgCyv9hdTsUdxLpXvI6iLp1M=
X-Received: by 2002:a17:90b:38c8:b0:2f4:434d:c7f0 with SMTP id
 98e67ed59e1d1-2ff7ce6f953mr14161511a91.12.1741444126347; Sat, 08 Mar 2025
 06:28:46 -0800 (PST)
MIME-Version: 1.0
References: <20250306133713.393057-1-getelson@nvidia.com>
In-Reply-To: <20250306133713.393057-1-getelson@nvidia.com>
From: Igor Gutorov <igootorov@gmail.com>
Date: Sat, 8 Mar 2025 17:28:09 +0300
X-Gm-Features: AQ5f1JpV8BAUVjNIUqHOIWYuSRaTx_nQwZk5xywCbo6RHd4y_xPbbFnPL8l35-g
Message-ID: <CAL7bPf2ddD=Hnw19uO-EzBBYYZz2vYUKxWapYoYK9Qqt7wdbfA@mail.gmail.com>
Subject: Re: [PATCH] rust: support DPDK API
To: Gregory Etelson <getelson@nvidia.com>
Cc: dev@dpdk.org, thomas@monjalon.net, mkashani@nvidia.com, 
 Bruce Richardson <bruce.richardson@intel.com>
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

Hi Gregory!

As a DPDK as well as a Rust user, I'm quite excited about this patch.
I'm wondering though, is DPDK getting an official Rust API? I'm
subscribed to dev and user mailing lists, and haven't seen any
announcements - did I miss something?

Bellow are some stylistic suggestions

On Thu, Mar 6, 2025 at 4:38=E2=80=AFPM Gregory Etelson <getelson@nvidia.com=
> wrote:
>
> The patch converts include files with DPDK API to RUST and binds new
> RUST API files info dpdklib package.
>
> The RUST dpdklib files and DPDK libraries build from C sources
> allow creation of DPDK application in RUST.
>
> RUST DPDK application must specify the `dpdklib` package as
> dependency in Cargo.toml file.
>
> RUST `dpdklib` package is installed into
> MESON_INSTALL_DESTDIR_PREFIX/rust directory.
>
> Software requirements:
> - clang
> - RUST installation
> - bindgen-cli crate
>
> RUST dpdklib installation instructions:
> 1. Configure DPDK with `-Deanble_rust=3Dtrue`
> 2. Build and install DPDK. The installation procedure will create
>    MESON_INSTALL_DESTDIR_PREFIX/rust directory.
> 3. Update PKG_CONFIG_PATH to point to DPDK installation.
>
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> ---
>  buildtools/meson.build               |   4 +
>  buildtools/rust-env.sh               |  78 +++++++++++
>  examples/rust/helloworld/Cargo.lock  |  14 ++
>  examples/rust/helloworld/Cargo.toml  |   7 +
>  examples/rust/helloworld/build.rs    |  21 +++
>  examples/rust/helloworld/src/main.rs | 197 +++++++++++++++++++++++++++
>  meson_options.txt                    |   2 +
>  7 files changed, 323 insertions(+)
>  create mode 100755 buildtools/rust-env.sh
>  create mode 100644 examples/rust/helloworld/Cargo.lock
>  create mode 100644 examples/rust/helloworld/Cargo.toml
>  create mode 100644 examples/rust/helloworld/build.rs
>  create mode 100644 examples/rust/helloworld/src/main.rs
>
> diff --git a/buildtools/meson.build b/buildtools/meson.build
> index 4e2c1217a2..dd16567f51 100644
> --- a/buildtools/meson.build
> +++ b/buildtools/meson.build
> @@ -50,3 +50,7 @@ else
>      pmdinfo +=3D 'ar'
>      pmdinfogen +=3D 'elf'
>  endif
> +
> +if get_option('enable_rust')
> +    meson.add_install_script('rust-env.sh')
> +endif
> diff --git a/buildtools/rust-env.sh b/buildtools/rust-env.sh
> new file mode 100755
> index 0000000000..705bc0d95b
> --- /dev/null
> +++ b/buildtools/rust-env.sh
> @@ -0,0 +1,78 @@
> +#! /bin/sh
> +
> +# Convert DPDK API files into RUST.
> +# DPDK files selection is on demand.
> +#
> +# The coversion is done in 4 stages:
nit: typo (coversion -> conversion)

> +# 1. Preparation [Optional]
> +#    Due to the bindgen conversion utility limitations source file may n=
eed
> +#    manual adjustment.
> +# 2. Preprocessing [Mandatory]
> +#    Run preprocessor on a source file before conversion.
> +# 3. Conversion [Mandatory]
> +#    Convert preprocessed C file into RUST file
> +# 4. Post translation [Optional]
> +#    Manually fix translation.
> +
> +# DPDK files list
> +files=3D'
> +rte_build_config.h
> +rte_eal.h
> +rte_ethdev.h
> +rte_mbuf.h
> +rte_mbuf_core.h
> +rte_mempool.h
> +'
> +
> +rust_dir=3D"${MESON_INSTALL_DESTDIR_PREFIX}/rust"
> +include_dir=3D"${MESON_INSTALL_DESTDIR_PREFIX}/include"
> +
> +if test -d "$rust_dir"; then
> +  rm -rf "$rust_dir"
> +fi
> +
> +mkdir -p "$rust_dir/src"
> +if ! test -d "$rust_dir"; then
> +  echo "failed to create Rust library $rust_dir"
> +  exit 255
> +fi
> +touch "$rust_dir/src/lib.rs"
> +
> +bindgen_opt=3D'--no-layout-tests --no-derive-debug'
> +bindgen_clang_opt=3D'-Wno-unused-command-line-argument'
> +
> +create_rust_lib ()
> +{
> +  base=3D$1
> +
> +  cp $include_dir/${base}.h /tmp/${base}.h
> +
> +# bindgen cannot process complex macro definitions
> +# manually simplify macros before conversion
> +  sed -i -e 's/RTE_BIT64(\([0-9]*\))/(1UL << \1)/g' /tmp/${base}.h
> +  sed -i -e 's/RTE_BIT32(\([0-9]*\))/(1U << \1)/g' /tmp/${base}.h
> +  sed -i -e 's/UINT64_C(\([0-9]*\))/\1/g' /tmp/${base}.h
> +
> +  # clang output has better integration with bindgen than GCC
> +  clang -E -dD -I$include_dir /tmp/${base}.h > /tmp/$base.i
> +  bindgen $bindgen_opt --output $rust_dir/src/$base.rs /tmp/$base.i -- $=
bindgen_clang_opt
> +  rm -f /tmp/$base.i /tmp/$base.h
> +}
> +
> +for file in $files; do
> +  base=3D$(basename $file | cut -d. -f 1)
> +  create_rust_lib $base
> +  echo "pub mod $base;" >> "$rust_dir/src/lib.rs"
> +done
> +
> +
> +cat > "$rust_dir/Cargo.toml" <<EOF
> +[package]
> +name =3D "dpdklib"
> +version =3D "$(cat $MESON_SOURCE_ROOT/VERSION | sed 's/\.0\([1-9]\)/\.\1=
/')"
> +EOF
> +
> +# post conversion updates
> +# RUST does not accept aligned structures into packed structure.
> +# TODO: fix DPDK definitions.
> +sed -i 's/repr(align(2))/repr(packed(2))/g'  "$rust_dir/src/rte_ethdev.r=
s"
> diff --git a/examples/rust/helloworld/Cargo.lock b/examples/rust/hellowor=
ld/Cargo.lock
> new file mode 100644
> index 0000000000..d18af80c66
> --- /dev/null
> +++ b/examples/rust/helloworld/Cargo.lock
> @@ -0,0 +1,14 @@
> +# This file is automatically @generated by Cargo.
> +# It is not intended for manual editing.
> +version =3D 4
> +
> +[[package]]
> +name =3D "dpdklib"
> +version =3D "25.3.0-rc1"
> +
> +[[package]]
> +name =3D "helloworld"
> +version =3D "0.1.0"
> +dependencies =3D [
> + "dpdklib",
> +]
> diff --git a/examples/rust/helloworld/Cargo.toml b/examples/rust/hellowor=
ld/Cargo.toml
> new file mode 100644
> index 0000000000..7f9a77968a
> --- /dev/null
> +++ b/examples/rust/helloworld/Cargo.toml
> @@ -0,0 +1,7 @@
> +[package]
> +name =3D "helloworld"
> +version =3D "0.1.0"
> +edition =3D "2024"
> +
> +[dependencies]
> +dpdklib =3D {path =3D "MESON_INSTALL_DESTDIR_PREFIX/rust"}
> \ No newline at end of file
> diff --git a/examples/rust/helloworld/build.rs b/examples/rust/helloworld=
/build.rs
> new file mode 100644
> index 0000000000..5c76188e18
> --- /dev/null
> +++ b/examples/rust/helloworld/build.rs
> @@ -0,0 +1,21 @@
> +use std::process::Command;
> +
> +pub fn main() {
> +    let mut pkgconfig =3D Command::new("pkg-config");
> +
> +    match pkgconfig.args(["--libs", "libdpdk"]).output() {
> +        Ok (output) =3D> {
> +            let stdout =3D String::from_utf8_lossy(&output.stdout).trim_=
end().to_string();
> +            for token in stdout.split_ascii_whitespace().filter(|s| !s.i=
s_empty()) {
> +                if token.starts_with("-L") {
> +                    println!("cargo::rustc-link-search=3Dnative=3D{}", &=
token[2..]);
> +                } else if token.starts_with("-l") {
> +                    println!("cargo::rustc-link-lib=3D{}", &token[2..]);
> +                }
> +            }
> +        }
> +        Err(error) =3D> {
> +            panic!("failed to read libdpdk package: {:?}", error);
> +        }
> +    }
> +}
> diff --git a/examples/rust/helloworld/src/main.rs b/examples/rust/hellowo=
rld/src/main.rs
> new file mode 100644
> index 0000000000..cf666aece6
> --- /dev/null
> +++ b/examples/rust/helloworld/src/main.rs
> @@ -0,0 +1,197 @@
> +/// Usage: helloworld -a <port 1 params> -a <port 2 params> ...
> +
> +use std::env;
> +use std::ffi::{CString};
> +use std::os::raw::{c_int, c_char};
> +use std::ffi::CStr;
> +
> +use dpdklib::rte_eal::{
> +    // Functions
> +    rte_eal_init,
> +    rte_eal_cleanup,
> +};
> +
> +use dpdklib::rte_ethdev::{
> +    RTE_ETH_NAME_MAX_LEN,
> +    RTE_ETH_DEV_NO_OWNER,
> +    RTE_ETH_RSS_IP,
> +    rte_eth_rx_mq_mode_RTE_ETH_MQ_RX_RSS,
> +    rte_eth_rx_mq_mode_RTE_ETH_MQ_RX_VMDQ_DCB_RSS,
> +
> +    // Structures
> +    rte_eth_dev_info,
> +    rte_eth_conf,
> +    rte_eth_txconf,
> +    rte_eth_rxconf,
> +
> +    // Functions
> +    rte_eth_dev_get_name_by_port,
> +    rte_eth_find_next_owned_by,
> +    rte_eth_dev_info_get,
> +    rte_eth_dev_configure,
> +    rte_eth_tx_queue_setup,
> +    rte_eth_rx_queue_setup,
> +    rte_eth_dev_start,
> +};
> +
> +use dpdklib::rte_build_config::{
> +    RTE_MAX_ETHPORTS,
> +};
> +
> +use dpdklib::rte_mbuf::{
> +    rte_pktmbuf_pool_create,
> +};
> +
> +use dpdklib::rte_mbuf_core::{
> +    RTE_MBUF_DEFAULT_BUF_SIZE
> +};
> +
> +pub type DpdkPort =3D u16;
> +pub struct Port {
> +    pub port_id:DpdkPort,
> +    pub dev_info:rte_eth_dev_info,
> +    pub dev_conf:rte_eth_conf,
> +    pub rxq_num:u16,
> +    pub txq_num:u16,
> +}
> +
> +impl Port {
> +    unsafe fn new(id:DpdkPort) -> Self {
> +        Port {
> +            port_id:id,
> +            dev_info: unsafe {
> +                let uninit: ::std::mem::MaybeUninit<rte_eth_dev_info> =
=3D ::std::mem::MaybeUninit::zeroed().assume_init();
> +                *uninit.as_ptr()
> +            },
> +            dev_conf: unsafe {
> +                let uninit: ::std::mem::MaybeUninit<rte_eth_conf> =3D ::=
std::mem::MaybeUninit::zeroed().assume_init();
> +                *uninit.as_ptr()
> +            },
> +            rxq_num:1,
> +            txq_num:1,
> +        }
> +    }
> +}
> +
> +pub unsafe fn iter_rte_eth_dev_owned_by(owner_id:u64) -> impl Iterator<I=
tem=3DDpdkPort> {
> +    let mut port_id:DpdkPort =3D 0 as DpdkPort;
> +    std::iter::from_fn(move || {
> +        let cur =3D port_id;
> +        port_id =3D unsafe {
> +            rte_eth_find_next_owned_by(cur, owner_id) as DpdkPort
> +        };
> +        if port_id =3D=3D RTE_MAX_ETHPORTS as DpdkPort {
> +            return None
> +        }
> +        if cur =3D=3D port_id { port_id +=3D 1 }
> +        Some(cur)
> +    })
> +}
> +
> +pub unsafe fn iter_rte_eth_dev() -> impl Iterator<Item=3DDpdkPort> {
> +    unsafe {
> +      iter_rte_eth_dev_owned_by(RTE_ETH_DEV_NO_OWNER as u64)
> +    }
> +}

It seems to me that it is expected to avoid iterating more than
`RTE_MAX_ETHPORTS` times.
I'd suggest to add a `.take()` call here:

pub unsafe fn iter_rte_eth_dev() -> impl Iterator<Item=3DDpdkPort> {
    unsafe {
      iter_rte_eth_dev_owned_by(RTE_ETH_DEV_NO_OWNER as u64)
    }
    .take(dpdklib::rte_build_config::RTE_MAX_ETHPORTS as usize)
}

Then the users of this function don't need to know about this detail.
Also, would this make `iter_rte_eth_dev()` safe?

> +
> +pub unsafe fn init_port_config(port: &mut Port) {
> +    let ret =3D unsafe {
> +        rte_eth_dev_info_get(port.port_id, &mut port.dev_info as *mut rt=
e_eth_dev_info)
> +    };
> +    if ret !=3D 0 {
> +        panic!("port-{}: failed to get dev info {ret}", port.port_id);
> +    }
> +
> +    port.dev_conf.rx_adv_conf.rss_conf.rss_key =3D std::ptr::null_mut();
> +    port.dev_conf.rx_adv_conf.rss_conf.rss_hf =3D if port.rxq_num > 1 {
> +        RTE_ETH_RSS_IP as u64 & port.dev_info.flow_type_rss_offloads
> +    } else {0};
> +
> +    if port.dev_conf.rx_adv_conf.rss_conf.rss_hf !=3D 0 {
> +        port.dev_conf.rxmode.mq_mode =3D
> +            rte_eth_rx_mq_mode_RTE_ETH_MQ_RX_VMDQ_DCB_RSS & rte_eth_rx_m=
q_mode_RTE_ETH_MQ_RX_RSS;
> +    }
> +}
> +
> +pub unsafe fn show_ports_summary(ports: &Vec<Port>) {
Is it safe to remove `unsafe` here? Since `Port` is already
initialized, all of the calls inside this function should be valid,
unless I'm missing something.

> +    let mut name_buf:[c_char;RTE_ETH_NAME_MAX_LEN as usize]=3D [0 as c_c=
har;RTE_ETH_NAME_MAX_LEN as usize];
> +    let title =3D format!("{:<4}    {:<32} {:<14}", "Port", "Name", "Dri=
ver");
> +    println!("{title}");
> +    ports.iter().for_each(|p| unsafe {
> +        let _rc =3D rte_eth_dev_get_name_by_port(p.port_id, name_buf.as_=
mut_ptr());
> +        let name =3D CStr::from_ptr(name_buf.as_ptr());
> +        let drv =3D CStr::from_ptr(p.dev_info.driver_name);
> +        let summary =3D format!("{:<4}    {:<32} {:<14}",
> +                              p.port_id, name.to_str().unwrap(), drv.to_=
str().unwrap());
> +        println!("{summary}");
> +    });
> +
> +}
> +unsafe fn start_port(port:&mut Port) {
Same here with `unsafe` as with `show_ports_summary`. It seems all
error conditions are checked, and the application terminates if
something goes wrong.

> +    let mut rc =3D unsafe {
> +      rte_eth_dev_configure(port.port_id, port.rxq_num, port.txq_num,
> +                            &port.dev_conf as *const rte_eth_conf)
> +    };
> +    if rc !=3D 0 { panic!("failed to configure port-{}: {rc}", port.port=
_id)}
> +    println!("port-{} configured", port.port_id);
> +
> +    rc =3D unsafe {
> +      rte_eth_tx_queue_setup(port.port_id, 0, 64, 0, 0 as *const rte_eth=
_txconf)
> +    };
> +    if rc !=3D 0 { panic!("port-{}: failed to configure TX queue 0 {rc}"=
, port.port_id)}
> +    println!("port-{} configured TX queue 0", port.port_id);
> +
> +    let mbuf_pool_name =3D CString::new(format!("mbuf pool port-{}", por=
t.port_id)).unwrap();
> +    let mbuf_pool : *mut dpdklib::rte_mbuf::rte_mempool =3D unsafe {
> +        rte_pktmbuf_pool_create(mbuf_pool_name.as_ptr(), 1024, 0, 0,
> +                                RTE_MBUF_DEFAULT_BUF_SIZE as u16, 0)
> +    };
> +    if mbuf_pool  =3D=3D 0 as *mut dpdklib::rte_mbuf::rte_mempool {
nit: I'd suggest

if mbuf_pool.is_null() {
    ...
}

> +        panic!("port-{}: failed to allocate mempool {rc}", port.port_id)
> +    }
> +    println!("port-{} mempool ready", port.port_id);
> +
> +    let mut rxq_conf:rte_eth_rxconf =3D port.dev_info.default_rxconf.clo=
ne();
> +    rxq_conf.offloads =3D 0;
> +    rc =3D unsafe {
> +        rte_eth_rx_queue_setup(port.port_id, 0, 64, 0,
> +                               &mut rxq_conf as *mut rte_eth_rxconf,
> +                               mbuf_pool as *mut dpdklib::rte_ethdev::rt=
e_mempool)
This is quite pedantic, but it is often recommended to use `.cast()`
in raw pointer casting:
`mbuf_pool.cast::<dpdklib::rte_ethdev::rte_mempool>()` or even simply
`mbuf_pool.cast()`. [1].

> +    };
> +    if rc !=3D 0 { panic!("port-{}: failed to configure RX queue 0 {rc}"=
, port.port_id)}
> +    println!("port-{} configured RX queue 0", port.port_id);
> +    rc =3D unsafe {
> +        rte_eth_dev_start(port.port_id)
> +    };
> +    if rc !=3D 0 { panic!("failed to start port-{}: {rc}", port.port_id)=
}
> +    println!("port-{} started", port.port_id);
> +}
> +
> +fn main() {
> +
> +    let mut argv: Vec<*mut c_char> =3D env::args()
> +        .map(|arg| CString::new(arg).unwrap().into_raw()).collect();
> +
> +    let rc =3D unsafe {
> +        rte_eal_init(env::args().len() as c_int, argv.as_mut_ptr())
> +    };
> +    if rc =3D=3D -1 {
> +        unsafe { rte_eal_cleanup(); }
> +    }
> +
> +    let mut ports:Vec<Port> =3D vec![];
> +    unsafe {
> +        for port_id in iter_rte_eth_dev()
> +            .take(dpdklib::rte_build_config::RTE_MAX_ETHPORTS as usize) =
{
> +            let mut port =3D Port::new(port_id);
> +            init_port_config(&mut port);
> +            println!("init port {port_id}");
> +            start_port(&mut port);
> +            ports.push(port);
> +        }
> +    }

If you prefer, this can be written like so:

let ports: Vec<Port> =3D unsafe {
    iter_rte_eth_dev()
        .take(dpdklib::rte_build_config::RTE_MAX_ETHPORTS as usize)
        .map(|port_id| {
            let mut port =3D Port::new(port_id);
            init_port_config(&mut port);
            println!("init port {port_id}");
            start_port(&mut port);
            port
        })
        .collect()
}

> +
> +    unsafe { show_ports_summary(&ports); }
> +
> +    println!("Hello, world!");
> +}
> diff --git a/meson_options.txt b/meson_options.txt
> index e49b2fc089..d37b9ba1dc 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -60,3 +60,5 @@ option('tests', type: 'boolean', value: true, descripti=
on:
>         'build unit tests')
>  option('use_hpet', type: 'boolean', value: false, description:
>         'use HPET timer in EAL')
> +option('enable_rust', type: 'boolean', value: false, description:
> +       'enable RUST')
> --
> 2.45.2
>

Some other thoughts/suggestions:
- Indentation/styling is a bit off or inconsistent. I'd suggest to run
`cargo fmt` to format the code. It is possible to configure the output
to match DPDK's needs [2]. Also, `cargo fmt --check` can check if
`rustfmt` would make any formatting changes. This could be a part of
the checks in `devtools` in the future.
- I haven't checked, but I think some of my suggestions would pop up
by `cargo clippy` analysis. It may be worth having this tool be a part
of the `devtools` checks as well in the future.
- I'd make `init_port_config` and `start_port` a method on `Port`,
rather than a free function, but that's just my preference.

[1] https://github.com/rust-lang/rust-clippy/issues/8017
[2] https://rust-lang.github.io/rustfmt/?version=3Dmaster&search=3D

--
Regards,
Igor Gutorov
