Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0E1C369C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 11:42:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71C6B40B98;
	Wed, 16 Apr 2025 13:42:22 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by mails.dpdk.org (Postfix) with ESMTP id 9F0E3406B8
 for <dev@dpdk.org>; Wed, 16 Apr 2025 13:42:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkZOdmX4CbHW84cI/oeKFd8r+BZfhdiEJ9D8lxhrYyuSGhHEb9khdMoVmqyh58OdccU7BvKiqW0toqEANMgB+0t0hX+7VEpGsazgPEt5Eb5NKVEQpcaxQtBWKJIUYibSZuWUICFuO1WIeFzc040nUV+6URYWiGMCTIt4Af6h9mC999zIdR3z5c6p3LvGs/Zn8aGORbgeYVZQ8IOYmquZWd4/kku0zJ6q7W5wDWhM6u6RvRY1iNqspxSHpkPLG+V0ovwHh/z6L/DJTq+hep4YbSFyl2ItvRrRinp7zO6Z1fiuLgpvVZXcHchPh7EUbqhfn0OuIv+mofVwCP/H5dC8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaQzL9VRddbfXR9yFX9AVAEapSXf73D5SnB1G+Z7mps=;
 b=Ula0XCOrkkaVvzllNuevUJV0W8vlXUsuEamg+2e1frGy8C7mi7Slx4kFq3rRqhwm/oFKQKGDVTu+3T+VtAf0yqCVTYEwj36dEPtlQgg0WkSuU522hFUXAo7xNBNPVZ/fGISAYKidZ6BBhiBoYQtgUYBk7XwrkPgTr2WA4wQhb8r72bWkUpD1bwp0YX0KSrERtbPW5xESUXi4fDWdB3fuuDflB1alQA8qCssfX6S3lQGlrirg1Mw1GJj2VEjRNzNIOR/5GiDr93ZftHPCjxrJV6+dVuO7hHnkbN+PBgyDn/rZXgzQ3APmKZRcZPq9HftceBgE+W8CSi+NN+/C2X0GDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaQzL9VRddbfXR9yFX9AVAEapSXf73D5SnB1G+Z7mps=;
 b=idXkoEVQE0iG/eVuKJtzB95/yFVbdID3GCw38s3l3FbGQw0S/jVnSWUDfzlWnl3D3xbKZxmeMcVmhyfbVfl1HaMJtQQiG0SUb4hGZ4t+PFmqREcgaBst6EgA60IAq3jjhY1xlzY0V+j3kXrwFAd7dFGlZ4OfDz3zlu0PHRrcC59ZMVuSQBooXOhJTt4zEYEp+FtCM5Nr6OMgDoqEPqjRj/+YAQj4tdjHvb3UFcE9TPSd9rrMBdVqrjAOs1dkKwmuHgsrpYQzUbKwktgxuoWH3KE6GJ6D5CczGQDwLRaawrvPvgOLrXU3QCk4M8dVGFyEjH/+ZMznn14bFAlCE2Yvqg==
Received: from IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22)
 by SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 11:42:18 +0000
Received: from IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de]) by IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de%6]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 11:42:17 +0000
From: Gregory Etelson <getelson@nvidia.com>
To: "Harry\"" <harry.van.haaren@intel.com>, "Bruce\""
 <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: [RFC] add Rust API for basic port operations
Thread-Topic: [RFC] add Rust API for basic port operations
Thread-Index: AQHbrr+LK/ZTHNB7W0+EGKQZdXJ9pQ==
Date: Wed, 16 Apr 2025 11:42:17 +0000
Message-ID: <IA1PR12MB633009C4430CF2081D824D3AA5BD2@IA1PR12MB6330.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6330:EE_|SN7PR12MB7021:EE_
x-ms-office365-filtering-correlation-id: 32b466cc-017a-4c9f-379f-08dd7cdbbdb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|8096899003|13003099007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?hS2uCH9/pbUrzlk/nKLTd6c2656EOPWyUrm0d8StxaoaK9EYAOS6dkJI4w?=
 =?iso-8859-1?Q?7REtFLoFpmMETM9sWzKBcaABsCeEQvItRXvxJ3OpqHkG7HDoofJUMXM7kY?=
 =?iso-8859-1?Q?ymaJIjnDdrtkLI7VSMlqHa5DzGCYUx9te5zfEMVAewKSgjfSLp+eYx6L/k?=
 =?iso-8859-1?Q?K97gmDEYFDrrQHPI6v7NnMXxo91TNh29dQcJC1GGET6ufAl/LS+5AwH0QX?=
 =?iso-8859-1?Q?+zDYfIFkTqnh/2VmKf0mFs2jGkjr1qwV96sP6WxjLItFF+Lsx8mrpmyJkX?=
 =?iso-8859-1?Q?pxoJ+j9Dw2d+AMEALnTgN0ExkSIzLle7JgxDlHo+VEy+Hj9mpci4OZo17q?=
 =?iso-8859-1?Q?MO2IFWIhrN1pcDwhQQCaaRE1pC+xySE17Q6bvPumcP4mJ8mTgw4MiEFa9h?=
 =?iso-8859-1?Q?uEee1bJg2zOgLrNUKD/cKvQ/nDiuptvc0GBmc3aqUS2xw1EqTv6f326d8m?=
 =?iso-8859-1?Q?gUWXA/MCnHKgK7CbdESC9Fzp8FDq2a8CVfrUhJBsVTRPyefkQPvnvjKJL6?=
 =?iso-8859-1?Q?lAt9H3U8/Tuy1ft6oMlqTg0oXUq+9nULfwVL0g+OqBFealIeaK23teGxQf?=
 =?iso-8859-1?Q?Xkb79iG2soVftU1NweeoeLyXmC95TtQyoF61bcrLb6/NO1/FswhrpgBXdf?=
 =?iso-8859-1?Q?iWQtaPR3v5PSvTYPXNABrOGRNK0ae8g0dONUFxIF8A/mqHcwzK5PvFe1Xk?=
 =?iso-8859-1?Q?07dSV6Y2Kyq0unVYyroT7soF//lWSFwiFqGNoqH0CpAZUTpq/IC6bCXnKE?=
 =?iso-8859-1?Q?EE0fgxpBGL/vrS3Dzytd0XlNcq9VfMXc6v8IwH81nVXheSeu3MYotokReH?=
 =?iso-8859-1?Q?IcMqFXyYU1xoRcQi3rxM25uXtbuJHlVRSS9S5mQ0ZP+41SOzqZW2GVbA8G?=
 =?iso-8859-1?Q?hb7Sr8AY4jAVtmnvMVzI1QmVHaLkmFk/B3jNPPGMHnHNtrHLAiCv+cA2A1?=
 =?iso-8859-1?Q?xBQEep2ZULM9zOzCd67WC4mEmD5WVdqO6G/nuqC6m43HLA3B1Z+tmbHKy5?=
 =?iso-8859-1?Q?r/rN6OeQR1ycvhRlNxgdbnGj1goaBVcG2DBK8tbV64JFYfksMo7ADAlHMU?=
 =?iso-8859-1?Q?DFxOzpdm9Qu4hhbFS5twIuB7Bokv6BMjpglmMKsuCEmpjQ3NhYvF9DAVMg?=
 =?iso-8859-1?Q?n3h9OLXv1VGS+FGXMiTnj817Mu4CFkPgdFo3W2/bxbhe40F1tPsx9+N/KF?=
 =?iso-8859-1?Q?FBnH7iNgenZHDWcptxQBmmlAkUts+4sgN3FRIjitHXcbZsdJOELnu/rZeV?=
 =?iso-8859-1?Q?lX9qoLGJSoCUbCwRCQE+WRKR6tWMok2i745j1iJ8O4e7ar3fxzEnadgMmM?=
 =?iso-8859-1?Q?qF8FXp/Rdl2sezobyBrqyigaPSoiQphX8P9rXg1zHmomndajZa2wCKvTg8?=
 =?iso-8859-1?Q?56P9jM4giy4LJYuVoAsD5ZiefWP9JyvpAt5TcCPFV9vrm/4fj+e94ukYu7?=
 =?iso-8859-1?Q?h0RNpMtHIBBNjKjTISwfzFyv70CubyrdmJ6ntmkZaAbP2kUbrSX8yQHT3t?=
 =?iso-8859-1?Q?BR1TLRlSBsUPcevopevDxlcFZFGUPjWwswZr7uPubW8BEO4KmP1baxdpyG?=
 =?iso-8859-1?Q?JaWUH88=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6330.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(8096899003)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zNsHV9jrzCsm6UCDWTzNpLbzwu6kerx9URt2peZj7uw7AoZwoqkXfQnjHF?=
 =?iso-8859-1?Q?83vfM4VmVs/W0nTDLtv+lu5h8l/eTPj7pZOAXlV9ByLNUj6qtL8kCiWvCl?=
 =?iso-8859-1?Q?3YKkVOmZzrcOhoDmINlOuJcQWlpXK0nrksqTkHwFK2WrnkmX6VztEwuZjc?=
 =?iso-8859-1?Q?L9airNWGlcwIYZ/hsycSqk2Jh7XNGsuntP8PcCf4mRuqXahnxqfYm3YugH?=
 =?iso-8859-1?Q?qqRdUVn9Gf07tYMUDJjkBACsUhArkSLFvhICpBYqt0iThMbZxVnxHA6tT1?=
 =?iso-8859-1?Q?eWCiIg897S1ZwG3I3BmcU3IDKFeDvMjkLj8PCiKsuwQO4ZlsHsYOQnZnNk?=
 =?iso-8859-1?Q?gWvLj7K/JpweBI/TIY6imdQqrjXvtRZg6Sux9lEHdTAqwHQbCv1THe+AyW?=
 =?iso-8859-1?Q?fJTBkIlgLFLVG4I61ht9RmG90HBM6x7wro4JtJVthX8tmor9dd480DEeLu?=
 =?iso-8859-1?Q?jcyZyEVmMUMEYS5D2AzxcEkEJeNypdbccaWT+XGsbP49i3O7nXNLXJzT0X?=
 =?iso-8859-1?Q?4KjHsWKIyN8lSF2+M3/36k6P/LqQqtNo3PU7QAVfX8fKictl9WNAknbwpj?=
 =?iso-8859-1?Q?+iusLa6HlRsNuUFSlBRS9GZibsRJ1Slthla2dyUAHsgl8U89DzhoEnL/iQ?=
 =?iso-8859-1?Q?RDYYd4vCTApzL2eKGd66vDuJZGpZKzWI5cbzz4U9tdZUl9qVUi5PSD+rG0?=
 =?iso-8859-1?Q?ClW0yf/TCyy4rM4Fu1AJR+IPHhA7+Q6WtItKYoeXGTkec9mBQwELDi7321?=
 =?iso-8859-1?Q?214GAXp2ECywdWUr3N7tg8RXe4gvj4YQf0xCaBZdrk/bK7/5S+FNoPaYdA?=
 =?iso-8859-1?Q?U9GWYcL0TbiEKqxD2I0I7axtsPNE2JmdLz2j05HW/tj8dqeoVAfbeuFVzl?=
 =?iso-8859-1?Q?Vow9hcUbbZkbbIoTh7dp9xteMqVAv5BrOgeDaRPNqPHZXuXK3T/5++U8p9?=
 =?iso-8859-1?Q?aXb+CMiMsuVa0/QzlgA0oc0VDtbOO1Nd3cGlMyCPnFuy2CpSp1ti2miZRz?=
 =?iso-8859-1?Q?ZdftaA3OqxiXUWy2CMreZiZkjDXxPQrBscfn1SXIwZol/7T9gcQnvaCtrR?=
 =?iso-8859-1?Q?0ubnb3JBS2PvTv4acxTcMEK/3jUGPTivHV2YKfTk15sio2dX5eUrPBjfES?=
 =?iso-8859-1?Q?8zi8U3Oy3SUEWF3B7BJw3eOuJsy53uvx2TT1u+TDWbZe3xKh4obneveJAr?=
 =?iso-8859-1?Q?tkL/J2cV2NRo5eRdQx/iRq/onCDYyNFsYz+7bL4bMqyaAkaTKW2obdJm/I?=
 =?iso-8859-1?Q?IoGUfy1jWgKH8CtF1OtRk3jvbIqq+xHYQTs/NlMtL909zWWyfEaVU721cB?=
 =?iso-8859-1?Q?JCVf+T/Am36v/K94BgVSo7TaoACic7aNj7Ew7UcAPvfq8dUkV8MJDF2vbQ?=
 =?iso-8859-1?Q?gn+VYheobHuyJHpLDgpq87Yx+E/iw4zpCUz/PBZeyDhDn0YnxF9uFR+jdg?=
 =?iso-8859-1?Q?fnaZfBOi1rU8Bn5sxwwD318R6zMFAP6mrsEXuqpMkTErDOyDGxTw6agEbH?=
 =?iso-8859-1?Q?1lZqtxIeS2++VFiIkif4Fv6ZXt0Q0C3yL+0XIf662RvNewJiUP0kDHiI8Y?=
 =?iso-8859-1?Q?If3ZXKRdIWXJ+Th5nweMlzg9ZSdvCC6K6rHaPcwmp5ekTV8ZI4oLyXpNaD?=
 =?iso-8859-1?Q?gqSG36R0kqV8s=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA1PR12MB633009C4430CF2081D824D3AA5BD2IA1PR12MB6330namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b466cc-017a-4c9f-379f-08dd7cdbbdb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 11:42:17.8298 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 77FmLAih8RXsmG+dCwpjSUme5+gBeJI3SPbqS80KXxJtLzTvSgUe3i8ZQiv4yFu0MRkLhJ2IPeXJr8S1Y40Hxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021
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

--_000_IA1PR12MB633009C4430CF2081D824D3AA5BD2IA1PR12MB6330namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This RFC proposes Rust API for basic DPDK port management and IO operations=
.

```rust

/// Configuration details for a DPDK port.
///
/// # Overview
///
/// `DpdkPortConf` is used to initialize and configure ports in a DPDK envi=
ronment. It includes:
/// - Device information (`dev_info`) pulled from DPDK.
/// - Transmit and receive configurations, including queue settings and mem=
ory pools.
/// - Details about the number of queues and descriptors for transmission a=
nd reception.
///
/// This struct is typically instantiated using the [`DpdkPortConf::new_fro=
m`] method.
///
/// # Example
///
/// ```
/// let conf =3D DpdkPortConf::new_from(
///     port_id,
///     dev_conf,
///     tx_conf,
///     rx_conf,
///     8,               // Number of RX queues
///     8,               // Number of TX queues
///     512,             // RX descriptors
///     512,             // TX descriptors
///     0,               // RX queue socket ID
///     0,               // TX queue socket ID
///     Some(rx_mempool) // RX queue mempool
/// ).unwrap();
/// ```
///
#[derive(Clone)]
pub struct DpdkPortConf {
    /// Information about the DPDK Ethernet device (e.g., driver, capabilit=
ies, etc.).
    pub dev_info: rte_eth_dev_info,

    /// Configuration for the Ethernet device. Determines the overall behav=
ior of the device.
    pub dev_conf: rte_eth_conf,

    /// Configuration for transmitting (Tx) packets on the Ethernet device.
    pub tx_conf: rte_eth_txconf,

    /// Configuration for receiving (Rx) packets on the Ethernet device.
    pub rx_conf: rte_eth_rxconf,

    /// Number of receive (Rx) queues configured on this port.
    pub rxq_num: u16,

    /// Number of transmit (Tx) queues configured on this port.
    pub txq_num: u16,

    /// Number of descriptors for each transmit (Tx) queue.
    /// Descriptors represent items in a queue to handle packets.
    pub tx_desc_num: u16,

    /// Number of descriptors for each receive (Rx) queue.
    pub rx_desc_num: u16,

    /// NUMA socket ID associated with the memory used by receive (Rx) queu=
es.
    pub rxq_socket_id: u32,

    /// NUMA socket ID associated with the memory used by transmit (Tx) que=
ues.
    pub txq_socket_id: u32,

    /// Memory pool associated with receive (Rx) queues.
    /// This manages the buffers used for storing incoming packets.
    pub rxq_mempool: Option<Arc<DpdkMempool>>,
}


/// A trait defining basic operations for managing and interacting with a D=
PDK port.
///
/// # Overview
///
/// The `DpdkPort` trait standardizes how to operate on DPDK ports, making =
it possible to:
/// - Configure the Ethernet device using [`configure`].
/// - Start the device using [`start`].
/// - Handle Rx and Tx bursts of packets using [`rx_burst`] and [`tx_burst`=
].
///
pub trait DpdkPort: Send + Sync {
    /// Returns the port ID of the DPDK port.
    ///
    /// # Return Value
    /// A `u16` that uniquely identifies the DPDK port.
    ///
    /// # Example
    /// ```
    /// let port_id =3D dpdk_port.port_id();
    /// println!("DPDK port ID: {}", port_id);
    /// ```
    fn port_id(&self) -> u16;

    /// Returns a reference to the configuration object of the DPDK port.
    ///
    /// # Return Value
    /// A reference to [`DpdkPortConf`], which contains various settings li=
ke Rx/Tx queue configurations,
    /// memory pools, and NUMA socket IDs.
    ///
    /// # Example
    /// ```
    /// let port_config =3D dpdk_port.port_conf();
    /// println!("Rx queues: {}", port_config.rxq_num);
    /// ```
    fn port_conf(&self) -> &DpdkPortConf;

    /// Configures the DPDK Ethernet device with the settings specified in =
the port configuration.
    ///
    /// This method is typically called before starting the port to ensure =
it is prepared for Rx and Tx operations.
    ///
    /// # Return Value
    /// - `Ok(())` if the configuration was applied successfully.
    /// - `Err(String)` with a descriptive error message if the configurati=
on failed.
    ///
    /// # Example
    /// ```
    /// let result =3D dpdk_port.configure();
    /// if let Err(err) =3D result {
    ///     eprintln!("Failed to configure the port: {}", err);
    /// }
    /// ```
    fn configure(&mut self) -> Result<(), String>;

    /// Starts the DPDK Ethernet device.
    ///
    /// This method initializes the Rx and Tx queues, making the port ready=
 for data transmission
    /// and reception.
    ///
    /// # Return Value
    /// - `Ok(())` if the port was started successfully.
    /// - `Err(String)` if the startup process failed, with a descriptive e=
rror message.
    ///
    /// # Example
    /// ```
    /// let result =3D dpdk_port.start();
    /// if let Err(err) =3D result {
    ///     eprintln!("Failed to start the port: {}", err);
    /// }
    /// ```
    fn start(&mut self) -> Result<(), String>;

    /// Receives a burst of packets on the specified Rx queue.
    ///
    /// # Parameters
    /// - `queue_id`: The ID of the Rx queue to receive packets from.
    /// - `pkts`: A mutable reference to an array of packet buffers (`*mut =
rte_mbuf`) where received packets
    ///   will be written.
    ///
    /// # Return Value
    /// - `Ok(u16)` containing the number of packets successfully received.
    /// - `Err(String)` if the operation failed.
    ///
    /// # Example
    /// ```
    /// let pkts: Vec<*mut rte_mbuf> =3D vec![std::ptr::null_mut(); 32];
    /// let received =3D dpdk_port.rx_burst(0, &pkts);
    /// match received {
    ///     Ok(count) =3D> println!("Received {} packets", count),
    ///     Err(err) =3D> eprintln!("Rx burst failed: {}", err),
    /// }
    /// ```
    fn rx_burst(&mut self, queue_id: u16, pkts: &[*mut rte_mbuf]) -> Result=
<u16, String>;

    /// Sends a burst of packets on the specified Tx queue.
    ///
    /// # Parameters
    /// - `queue_id`: The ID of the Tx queue to send packets on.
    /// - `pkts`: A reference to an array of packet buffers (`*mut rte_mbuf=
`) to send.
    ///
    /// # Return Value
    /// - `Ok(u16)` containing the number of packets successfully sent.
    /// - `Err(String)` if the operation failed.
    ///
    /// # Example
    /// ```
    /// let pkts: Vec<*mut rte_mbuf> =3D vec![some_packet_ptr1, some_packet=
_ptr2];
    /// let sent =3D dpdk_port.tx_burst(0, &pkts);
    /// match sent {
    ///     Ok(count) =3D> println!("Sent {} packets", count),
    ///     Err(err) =3D> eprintln!("Tx burst failed: {}", err),
    /// }
    /// ```
    fn tx_burst(&mut self, queue_id: u16, pkts: &[*mut rte_mbuf]) -> Result=
<u16, String>;
}

```

The API uses raw FFI pointers in DpdkPort rx_burst() and tx_burst() to pres=
erve DPDK performance.

The API implementation is here:

API definition:
https://github.com/getelson-at-mellanox/rdpdk/blob/main/lib/port/port.rs

API implementation with RTE function calls:
https://github.com/getelson-at-mellanox/rdpdk/blob/main/lib/port/raw_port.r=
s

Implement direct calls to mlx5 Rx/Tx IO functions:
https://github.com/getelson-at-mellanox/rdpdk/blob/main/port/mlx5/mlx5_port=
.rs


Signed-off-by: Gregory Etelson <getelson@nvidia.com>






--_000_IA1PR12MB633009C4430CF2081D824D3AA5BD2IA1PR12MB6330namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: &quot;Aptos Mono&quot;,=
 Aptos_EmbeddedFont, Aptos_MSFontService, monospace; font-size: 11pt; color=
: rgb(0, 0, 0);">
This RFC proposes Rust API for basic DPDK port management and IO operations=
.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Aptos Mono&quot;,=
 Aptos_EmbeddedFont, Aptos_MSFontService, monospace; font-size: 11pt; color=
: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Aptos Mono&quot;,=
 Aptos_EmbeddedFont, Aptos_MSFontService, monospace; font-size: 11pt; color=
: rgb(0, 0, 0);">
```rust</div>
<pre><div class=3D"elementToProof" style=3D"font-family: &quot;Aptos Mono&q=
uot;, Aptos_EmbeddedFont, Aptos_MSFontService, monospace; font-size: 11pt; =
color: rgb(0, 0, 0);"><i>/// Configuration details for a DPDK port.<br>///<=
br>/// # Overview<br>///<br>/// `DpdkPortConf` is used to initialize and co=
nfigure ports in a DPDK environment. It includes:<br>/// - Device informati=
on (`dev_info`) pulled from DPDK.<br>/// - Transmit and receive configurati=
ons, including queue settings and memory pools.<br>/// - Details about the =
number of queues and descriptors for transmission and reception.<br>///<br>=
/// This struct is typically instantiated using the [`DpdkPortConf::new_fro=
m`] method.<br>///<br>/// # Example<br>///<br>/// ```<br>/// let conf =3D D=
pdkPortConf::new_from(<br>/// &nbsp; &nbsp; port_id,<br>/// &nbsp; &nbsp; d=
ev_conf,<br>/// &nbsp; &nbsp; tx_conf,<br>/// &nbsp; &nbsp; rx_conf,<br>///=
 &nbsp; &nbsp; 8, &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; // Numbe=
r of RX queues<br>/// &nbsp; &nbsp; 8, &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; // Number of TX queues<br>/// &nbsp; &nbsp; 512, &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; // RX descriptors<br>/// &nbsp; &nbsp; 512, &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; // TX descriptors<br>/// &nbsp; &nb=
sp; 0, &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; // RX queue socket =
ID<br>/// &nbsp; &nbsp; 0, &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 // TX queue socket ID<br>/// &nbsp; &nbsp; Some(rx_mempool) // RX queue me=
mpool<br>/// ).unwrap();<br>/// ```<br>/// <br></i>#[derive(Clone)]<br>pub =
struct DpdkPortConf {<br> &nbsp; &nbsp;<i>/// Information about the DPDK Et=
hernet device (e.g., driver, capabilities, etc.).<br> &nbsp; &nbsp;</i>pub =
dev_info: rte_eth_dev_info,<br><br> &nbsp; &nbsp;<i>/// Configuration for t=
he Ethernet device. Determines the overall behavior of the device.<br> &nbs=
p; &nbsp;</i>pub dev_conf: rte_eth_conf,<br><br> &nbsp; &nbsp;<i>/// Config=
uration for transmitting (Tx) packets on the Ethernet device.<br> &nbsp; &n=
bsp;</i>pub tx_conf: rte_eth_txconf,<br><br> &nbsp; &nbsp;<i>/// Configurat=
ion for receiving (Rx) packets on the Ethernet device.<br> &nbsp; &nbsp;</i=
>pub rx_conf: rte_eth_rxconf,<br><br> &nbsp; &nbsp;<i>/// Number of receive=
 (Rx) queues configured on this port.<br> &nbsp; &nbsp;</i>pub rxq_num: u16=
,<br><br> &nbsp; &nbsp;<i>/// Number of transmit (Tx) queues configured on =
this port.<br> &nbsp; &nbsp;</i>pub txq_num: u16,<br><br> &nbsp; &nbsp;<i>/=
// Number of descriptors for each transmit (Tx) queue.<br> &nbsp; &nbsp;///=
 Descriptors represent items in a queue to handle packets.<br> &nbsp; &nbsp=
;</i>pub tx_desc_num: u16,<br><br> &nbsp; &nbsp;<i>/// Number of descriptor=
s for each receive (Rx) queue.<br> &nbsp; &nbsp;</i>pub rx_desc_num: u16,<b=
r><br> &nbsp; &nbsp;<i>/// NUMA socket ID associated with the memory used b=
y receive (Rx) queues.<br> &nbsp; &nbsp;</i>pub rxq_socket_id: u32,<br><br>=
 &nbsp; &nbsp;<i>/// NUMA socket ID associated with the memory used by tran=
smit (Tx) queues.<br> &nbsp; &nbsp;</i>pub txq_socket_id: u32,<br><br> &nbs=
p; &nbsp;<i>/// Memory pool associated with receive (Rx) queues.<br> &nbsp;=
 &nbsp;/// This manages the buffers used for storing incoming packets.<br> =
&nbsp; &nbsp;</i>pub rxq_mempool: Option&lt;Arc&lt;DpdkMempool&gt;&gt;,<br>=
}</div><div class=3D"elementToProof" style=3D"white-space: normal; font-fam=
ily: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Aptos_MSFontService, monos=
pace; font-size: 11pt; color: rgb(0, 0, 0);"><br></div><pre><div class=3D"e=
lementToProof" style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_Embedded=
Font, Aptos_MSFontService, monospace; font-size: 11pt; color: rgb(0, 0, 0);=
"><i>/// A trait defining basic operations for managing and interacting wit=
h a DPDK port.<br>///<br>/// # Overview<br>///<br>/// The `DpdkPort` trait =
standardizes how to operate on DPDK ports, making it possible to:<br>/// - =
Configure the Ethernet device using [`configure`].<br>/// - Start the devic=
e using [`start`].<br>/// - Handle Rx and Tx bursts of packets using [`rx_b=
urst`] and [`tx_burst`].<br>///<br></i>pub trait DpdkPort: Send + Sync {<br=
> &nbsp; &nbsp;<i>/// Returns the port ID of the DPDK port.<br> &nbsp; &nbs=
p;///<br> &nbsp; &nbsp;/// # Return Value<br> &nbsp; &nbsp;/// A `u16` that=
 uniquely identifies the DPDK port.<br> &nbsp; &nbsp;///<br> &nbsp; &nbsp;/=
// # Example<br> &nbsp; &nbsp;/// ```<br> &nbsp; &nbsp;/// let port_id =3D =
dpdk_port.port_id();<br> &nbsp; &nbsp;/// println!(&quot;DPDK port ID: {}&q=
uot;, port_id);<br> &nbsp; &nbsp;/// ```<br> &nbsp; &nbsp;</i>fn port_id(&a=
mp;self) -&gt; u16;<br><br> &nbsp; &nbsp;<i>/// Returns a reference to the =
configuration object of the DPDK port.<br> &nbsp; &nbsp;///<br> &nbsp; &nbs=
p;/// # Return Value<br> &nbsp; &nbsp;/// A reference to [`DpdkPortConf`], =
which contains various settings like Rx/Tx queue configurations,<br> &nbsp;=
 &nbsp;/// memory pools, and NUMA socket IDs.<br> &nbsp; &nbsp;///<br> &nbs=
p; &nbsp;/// # Example<br> &nbsp; &nbsp;/// ```<br> &nbsp; &nbsp;/// let po=
rt_config =3D dpdk_port.port_conf();<br> &nbsp; &nbsp;/// println!(&quot;Rx=
 queues: {}&quot;, port_config.rxq_num);<br> &nbsp; &nbsp;/// ```<br> &nbsp=
; &nbsp;</i>fn port_conf(&amp;self) -&gt; &amp;DpdkPortConf;<br><br> &nbsp;=
 &nbsp;<i>/// Configures the DPDK Ethernet device with the settings specifi=
ed in the port configuration.<br> &nbsp; &nbsp;///<br> &nbsp; &nbsp;/// Thi=
s method is typically called before starting the port to ensure it is prepa=
red for Rx and Tx operations.<br> &nbsp; &nbsp;///<br> &nbsp; &nbsp;/// # R=
eturn Value<br> &nbsp; &nbsp;/// - `Ok(())` if the configuration was applie=
d successfully.<br> &nbsp; &nbsp;/// - `Err(String)` with a descriptive err=
or message if the configuration failed.<br> &nbsp; &nbsp;///<br> &nbsp; &nb=
sp;/// # Example<br> &nbsp; &nbsp;/// ```<br> &nbsp; &nbsp;/// let result =
=3D dpdk_port.configure();<br> &nbsp; &nbsp;/// if let Err(err) =3D result =
{<br> &nbsp; &nbsp;/// &nbsp; &nbsp; eprintln!(&quot;Failed to configure th=
e port: {}&quot;, err);<br> &nbsp; &nbsp;/// }<br> &nbsp; &nbsp;/// ```<br>=
 &nbsp; &nbsp;</i>fn configure(&amp;mut self) -&gt; Result&lt;(), String&gt=
;;<br><br> &nbsp; &nbsp;<i>/// Starts the DPDK Ethernet device.<br> &nbsp; =
&nbsp;///<br> &nbsp; &nbsp;/// This method initializes the Rx and Tx queues=
, making the port ready for data transmission<br> &nbsp; &nbsp;/// and rece=
ption.<br> &nbsp; &nbsp;///<br> &nbsp; &nbsp;/// # Return Value<br> &nbsp; =
&nbsp;/// - `Ok(())` if the port was started successfully.<br> &nbsp; &nbsp=
;/// - `Err(String)` if the startup process failed, with a descriptive erro=
r message.<br> &nbsp; &nbsp;///<br> &nbsp; &nbsp;/// # Example<br> &nbsp; &=
nbsp;/// ```<br> &nbsp; &nbsp;/// let result =3D dpdk_port.start();<br> &nb=
sp; &nbsp;/// if let Err(err) =3D result {<br> &nbsp; &nbsp;/// &nbsp; &nbs=
p; eprintln!(&quot;Failed to start the port: {}&quot;, err);<br> &nbsp; &nb=
sp;/// }<br> &nbsp; &nbsp;/// ```<br> &nbsp; &nbsp;</i>fn start(&amp;mut se=
lf) -&gt; Result&lt;(), String&gt;;<br><br> &nbsp; &nbsp;<i>/// Receives a =
burst of packets on the specified Rx queue.<br> &nbsp; &nbsp;///<br> &nbsp;=
 &nbsp;/// # Parameters<br> &nbsp; &nbsp;/// - `queue_id`: The ID of the Rx=
 queue to receive packets from.<br> &nbsp; &nbsp;/// - `pkts`: A mutable re=
ference to an array of packet buffers (`*mut rte_mbuf`) where received pack=
ets<br> &nbsp; &nbsp;/// &nbsp; will be written.<br> &nbsp; &nbsp;///<br> &=
nbsp; &nbsp;/// # Return Value<br> &nbsp; &nbsp;/// - `Ok(u16)` containing =
the number of packets successfully received.<br> &nbsp; &nbsp;/// - `Err(St=
ring)` if the operation failed.<br> &nbsp; &nbsp;///<br> &nbsp; &nbsp;/// #=
 Example<br> &nbsp; &nbsp;/// ```<br> &nbsp; &nbsp;/// let pkts: Vec&lt;*mu=
t rte_mbuf&gt; =3D vec![std::ptr::null_mut(); 32];<br> &nbsp; &nbsp;/// let=
 received =3D dpdk_port.rx_burst(0, &amp;pkts);<br> &nbsp; &nbsp;/// match =
received {<br> &nbsp; &nbsp;/// &nbsp; &nbsp; Ok(count) =3D&gt; println!(&q=
uot;Received {} packets&quot;, count),<br> &nbsp; &nbsp;/// &nbsp; &nbsp; E=
rr(err) =3D&gt; eprintln!(&quot;Rx burst failed: {}&quot;, err),<br> &nbsp;=
 &nbsp;/// }<br> &nbsp; &nbsp;/// ```<br> &nbsp; &nbsp;</i>fn rx_burst(&amp=
;mut self, queue_id: u16, pkts: &amp;[*mut rte_mbuf]) -&gt; Result&lt;u16, =
String&gt;;<br><br> &nbsp; &nbsp;<i>/// Sends a burst of packets on the spe=
cified Tx queue.<br> &nbsp; &nbsp;///<br> &nbsp; &nbsp;/// # Parameters<br>=
 &nbsp; &nbsp;/// - `queue_id`: The ID of the Tx queue to send packets on.<=
br> &nbsp; &nbsp;/// - `pkts`: A reference to an array of packet buffers (`=
*mut rte_mbuf`) to send.<br> &nbsp; &nbsp;///<br> &nbsp; &nbsp;/// # Return=
 Value<br> &nbsp; &nbsp;/// - `Ok(u16)` containing the number of packets su=
ccessfully sent.<br> &nbsp; &nbsp;/// - `Err(String)` if the operation fail=
ed.<br> &nbsp; &nbsp;///<br> &nbsp; &nbsp;/// # Example<br> &nbsp; &nbsp;//=
/ ```<br> &nbsp; &nbsp;/// let pkts: Vec&lt;*mut rte_mbuf&gt; =3D vec![some=
_packet_ptr1, some_packet_ptr2];<br> &nbsp; &nbsp;/// let sent =3D dpdk_por=
t.tx_burst(0, &amp;pkts);<br> &nbsp; &nbsp;/// match sent {<br> &nbsp; &nbs=
p;/// &nbsp; &nbsp; Ok(count) =3D&gt; println!(&quot;Sent {} packets&quot;,=
 count),<br> &nbsp; &nbsp;/// &nbsp; &nbsp; Err(err) =3D&gt; eprintln!(&quo=
t;Tx burst failed: {}&quot;, err),<br> &nbsp; &nbsp;/// }<br> &nbsp; &nbsp;=
/// ```<br> &nbsp; &nbsp;</i>fn tx_burst(&amp;mut self, queue_id: u16, pkts=
: &amp;[*mut rte_mbuf]) -&gt; Result&lt;u16, String&gt;;<br>}</div></pre></=
pre>
<div class=3D"elementToProof" style=3D"font-family: &quot;Aptos Mono&quot;,=
 Aptos_EmbeddedFont, Aptos_MSFontService, monospace; font-size: 11pt; color=
: rgb(0, 0, 0);">
```</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Aptos Mono&quot;,=
 Aptos_EmbeddedFont, Aptos_MSFontService, monospace; font-size: 11pt; color=
: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Aptos Mono&quot;,=
 Aptos_EmbeddedFont, Aptos_MSFontService, monospace; font-size: 11pt; color=
: rgb(0, 0, 0);">
The API uses raw FFI pointers in DpdkPort rx_burst() and tx_burst() to pres=
erve DPDK performance.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Aptos Mono&quot;,=
 Aptos_EmbeddedFont, Aptos_MSFontService, monospace; font-size: 11pt; color=
: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Aptos Mono&quot;,=
 Aptos_EmbeddedFont, Aptos_MSFontService, monospace; font-size: 11pt; color=
: rgb(0, 0, 0);">
The API implementation is here:<br>
<br>
API definition:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Aptos Mono&quot;,=
 Aptos_EmbeddedFont, Aptos_MSFontService, monospace; font-size: 11pt; color=
: rgb(0, 0, 0);">
<a href=3D"https://github.com/getelson-at-mellanox/rdpdk/blob/main/lib/port=
/port.rs" id=3D"LPlnk">https://github.com/getelson-at-mellanox/rdpdk/blob/m=
ain/lib/port/port.rs</a></div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Aptos Mono&quot;,=
 Aptos_EmbeddedFont, Aptos_MSFontService, monospace; font-size: 11pt; color=
: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Aptos Mono&quot;,=
 Aptos_EmbeddedFont, Aptos_MSFontService, monospace; font-size: 11pt; color=
: rgb(0, 0, 0);">
API implementation with RTE function calls:</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Aptos Mono&quot;,=
 Aptos_EmbeddedFont, Aptos_MSFontService, monospace; font-size: 11pt; color=
: rgb(0, 0, 0);">
<a href=3D"https://github.com/getelson-at-mellanox/rdpdk/blob/main/lib/port=
/raw_port.rs" id=3D"LPlnk">https://github.com/getelson-at-mellanox/rdpdk/bl=
ob/main/lib/port/raw_port.rs</a></div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Aptos Mono&quot;,=
 Aptos_EmbeddedFont, Aptos_MSFontService, monospace; font-size: 11pt; color=
: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Aptos Mono&quot;,=
 Aptos_EmbeddedFont, Aptos_MSFontService, monospace; font-size: 11pt; color=
: rgb(0, 0, 0);">
Implement direct calls to mlx5 Rx/Tx IO functions:&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Aptos Mono&quot;,=
 Aptos_EmbeddedFont, Aptos_MSFontService, monospace; font-size: 11pt; color=
: rgb(0, 0, 0);">
<a href=3D"https://github.com/getelson-at-mellanox/rdpdk/blob/main/port/mlx=
5/mlx5_port.rs" id=3D"LPlnk880790">https://github.com/getelson-at-mellanox/=
rdpdk/blob/main/port/mlx5/mlx5_port.rs</a></div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Aptos Mono&quot;,=
 Aptos_EmbeddedFont, Aptos_MSFontService, monospace; font-size: 11pt; color=
: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Aptos Mono&quot;,=
 Aptos_EmbeddedFont, Aptos_MSFontService, monospace; font-size: 11pt; color=
: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Aptos Mono&quot;,=
 Aptos_EmbeddedFont, Aptos_MSFontService, monospace; font-size: 11pt; color=
: rgb(0, 0, 0);">
Signed-off-by: Gregory Etelson &lt;getelson@nvidia.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Aptos Mono&quot;,=
 Aptos_EmbeddedFont, Aptos_MSFontService, monospace; font-size: 11pt; color=
: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apto=
s_MSFontService, monospace; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Aptos Mono&quot;,=
 Aptos_EmbeddedFont, Aptos_MSFontService, monospace; font-size: 11pt; color=
: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_IA1PR12MB633009C4430CF2081D824D3AA5BD2IA1PR12MB6330namp_--
